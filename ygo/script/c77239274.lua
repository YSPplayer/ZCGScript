--暗黑奥利哈刚之魂 （ZCG）
function c77239274.initial_effect(c)
	  --cost
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetTarget(c77239274.target)
	e2:SetOperation(c77239274.operation)
	c:RegisterEffect(e2)
end
function c77239274.filter(c)
	return c:IsControlerCanBeChanged()
end
function c77239274.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c77239274.filter(chkc) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE,1-tp,LOCATION_REASON_CONTROL)
	if chk==0 then return ft>0 and Duel.IsExistingTarget(c77239274.filter,tp,0,LOCATION_MZONE,1,nil) end
	local ct=math.min(ft,3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c77239274.filter,tp,0,LOCATION_MZONE,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,#g,0,0)
end
function c77239274.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.GetControl(tg,tp)~=0 then
	local number=0
	local tc=tg:GetFirst()
	while tc do
	number=number+tc:GetAttack()+tc:GetDefense()
	tc=tg:GetNext()
	end
	Duel.Recover(tp,number,REASON_EFFECT)
end
end