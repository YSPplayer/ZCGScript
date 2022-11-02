--植物の愤怒 绿能转化 (ZCG)
function c77239643.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
		--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77239643,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c77239643.spcon)
	e2:SetTarget(c77239643.sptg)
	e2:SetOperation(c77239643.spop)
	c:RegisterEffect(e2)
--control
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(77239643,3))
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c77239643.condition)
	e4:SetTarget(c77239643.ctltg)
	e4:SetOperation(c77239643.ctlop)
	c:RegisterEffect(e4)
end
function c77239643.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa90) and c:IsType(TYPE_MONSTER)
end
function c77239643.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77239643.cfilter,tp,LOCATION_ONFIELD,0,2,nil)
end
function c77239643.filter5(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c77239643.ctltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c77239643.filter5(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77239643.filter5,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c77239643.filter5,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c77239643.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		 Duel.GetControl(tc,tp)
	end
end

function c77239643.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp) and c:IsSetCard(0xa90)
end
function c77239643.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c77239643.cfilter,1,nil,tp)
end
function c77239643.dfilter(c,tp)
	return not c:IsLocation(LOCATION_DECK) and c:IsPreviousControler(tp) and c:IsSetCard(0xa90) and c:IsAbleToDeck()
end
function c77239643.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c77239643.dfilter,1,nil,tp) end
end
function c77239643.spop(e,tp,eg,ep,ev,re,r,rp)
	 local ct=eg:Filter(c77239643.dfilter,nil,tp)
	 local tc=ct:GetFirst()
	 local opt=Duel.SelectOption(tp,aux.Stringid(77239643,1),aux.Stringid(77239643,2))
	 if #ct>0 then
	 while tc do
	 if opt==0 then
	 Duel.SendtoDeck(tc,nil,0,REASON_EFFECT) 
	 elseif opt==1 then
	 Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
	 end
	 tc=ct:GetNext()
end
end
end






