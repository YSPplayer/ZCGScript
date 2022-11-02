--奥西里斯之太阳武士 （ZCG）
function c77239717.initial_effect(c)
	 --destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77239717,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_CONTROL+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c77239717.destg)
	e1:SetOperation(c77239717.desop)
	c:RegisterEffect(e1)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c77239717.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c77239717.efilter9)
	c:RegisterEffect(e13)
end
c77239717.toss_coin=true
function c77239717.disop9(e,tp,eg,ep,ev,re,r,rp)
	 local tc=re:GetHandler()
	if (tc:IsSetCard(0xa50) or tc:IsSetCard(0xa70)) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c77239717.efilter9(e,te)
	return te:GetHandler():IsSetCard(0xa60)
end
function c77239717.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c77239717.filter(c)
	return c:IsControlerCanBeChanged(true)
end
function c77239717.desop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==1 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	getmetatable(e:GetHandler()).announce_filter={0xa100,OPCODE_ISSETCARD}
	table.insert(getmetatable(e:GetHandler()).announce_filter,TYPE_MONSTER)
	table.insert(getmetatable(e:GetHandler()).announce_filter,OPCODE_ISTYPE)
	table.insert(getmetatable(e:GetHandler()).announce_filter,OPCODE_AND)
	local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
	local tc=Duel.CreateToken(tp,ac)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end 
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	elseif c1+c2==2 then
		local g=Duel.GetMatchingGroup(c77239717.filter,tp,0,LOCATION_MZONE,nil)
		Duel.GetControl(g,tp)
	--else return  end
	end
end
