--植物の愤怒 异变 (ZCG)
local m=77239651
local cm=_G["c"..m]
function c77239651.initial_effect(c)
			--cost
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCondition(cm.condition)
	e2:SetTarget(cm.ctltg)
	e2:SetOperation(cm.ctlop)
	c:RegisterEffect(e2)
end
function cm.cfilter(c)
	return c:IsFaceup()
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(cm.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function cm.filter5(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function cm.ctltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and cm.filter5(chkc) end
	if chk==0 then return Duel.IsExistingTarget(cm.filter5,tp,0,LOCATION_MZONE,1,nil) and Duel.IsExistingMatchingCard(cm.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,cm.filter5,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function cm.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		 if Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_MZONE,0,tc)==0 then return end
		 Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(98710670,1))
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,tc)
		Duel.GetControl(tc,tp)
		local c=e:GetHandler()
		local tc2=g:GetFirst()  
		local code=tc2:GetOriginalCodeRule()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end







