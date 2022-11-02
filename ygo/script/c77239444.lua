--六芒星反击 （ZCG）
function c77239444.initial_effect(c)
   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c77239444.condition)
	e1:SetTarget(c77239444.target)
	e1:SetOperation(c77239444.operation)
	c:RegisterEffect(e1)
end
function c77239444.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp) and c:IsSetCard(0xa71) and c:IsPreviousLocation(LOCATION_MZONE) 
end
function c77239444.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c77239444.cfilter,1,nil,tp)
end
function c77239444.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c77239444.operation(e,tp,eg,ep,ev,re,r,rp)
	  local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
