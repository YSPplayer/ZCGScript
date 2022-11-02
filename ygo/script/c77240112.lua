--太阳神的连续攻击 （ZCG）
function c77240112.initial_effect(c)
	  --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c77240112.condition)
	e1:SetTarget(c77240112.target)
	e1:SetOperation(c77240112.activate)
	c:RegisterEffect(e1)
--disable effect
	local e52=Effect.CreateEffect(c)
	e52:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e52:SetCode(EVENT_CHAIN_SOLVING)
	e52:SetRange(LOCATION_ONFIELD)
	e52:SetOperation(c77240112.disop2)
	c:RegisterEffect(e52)
	--disable
	local e53=Effect.CreateEffect(c)
	e53:SetType(EFFECT_TYPE_FIELD)
	e53:SetCode(EFFECT_DISABLE)
	e53:SetRange(LOCATION_ONFIELD)
	e53:SetTargetRange(0xa,0xa)
	e53:SetTarget(c77240112.distg2)
	c:RegisterEffect(e53)
	--self destroy
	local e54=Effect.CreateEffect(c)
	e54:SetType(EFFECT_TYPE_FIELD)
	e54:SetCode(EFFECT_SELF_DESTROY)
	e54:SetRange(LOCATION_ONFIELD)
	e54:SetTargetRange(0xa,0xa)
	e54:SetTarget(c77240112.distg2)
	c:RegisterEffect(e54)   
end
function c77240112.disop2(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_TRAP) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c77240112.distg2(e,c)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_TRAP)
		and c:GetCardTarget():IsContains(e:GetHandler())
end
function c77240112.cfilter(c) 
return c:IsSetCard(0xa210)
end
function c77240112.condition(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	return Duel.IsExistingMatchingCard(c77240112.cfilter,tp,LOCATION_MZONE,0,ct,nil)
end
function c77240112.filter(c)
	return c:IsFaceup() and c:IsCode(card77240112:GetCode())
end
function c77240112.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local tg=g:GetMaxGroup(Card.GetAttack)
	card77240112=tg:GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c77240112.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77240112.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c77240112.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c77240112.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsControler(tp) and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
   if Duel.GetMatchingGroupCount(Card.IsAbleToGrave,tp,LOCATION_MZONE,0,tc)>0 then 
	  local sg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_MZONE,0,tc)
	  Duel.SendtoGrave(sg,REASON_EFFECT)
		end
	end
end


