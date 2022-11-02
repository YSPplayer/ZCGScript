--奥西里斯之魔兽法师 （ZCG）
function c77240035.initial_effect(c)
	 --draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77240035,0))
	e2:SetRange(LOCATION_MZONE)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DRAW)
	e2:SetCountLimit(1)
	e2:SetCondition(c77240035.condition)
	e2:SetOperation(c77240035.activate)
	c:RegisterEffect(e2)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c77240035.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c77240035.efilter9)
	c:RegisterEffect(e13)
end
function c77240035.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c77240035.efilter9(e,te)
	return te:GetHandler():IsSetCard(0xa60)
end
function c77240035.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and r==REASON_RULE
end
function c77240035.dfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c77240035.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsLocation(LOCATION_HAND) then
		if tc:IsType(TYPE_MONSTER) and  tc:IsCanBeSpecialSummoned(e,0,tp,true,false) and  Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		
	else
		Duel.ShuffleHand(tp)
	end
end
end