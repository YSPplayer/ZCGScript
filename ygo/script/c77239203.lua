--奥利哈刚 艾恩哈特 （ZCG）
function c77239203.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xa50))
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(77239203,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c77239203.condition2)
	e2:SetCost(c77239203.cost2)
	e2:SetOperation(c77239203.operation2)
	c:RegisterEffect(e2)
end
function c77239203.atkfilter(c)
return c:IsFaceup()
end
function c77239203.condition2(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d~=nil and d:IsFaceup() and ((a:GetControler()==tp and a:IsSetCard(0xa50) and a:IsRelateToBattle())
		or (d:GetControler()==tp and d:IsSetCard(0xa50) and d:IsRelateToBattle()))
end
function c77239203.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c77239203.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() or Duel.GetMatchingGroupCount(c77239203.atkfilter,e:GetHandler():GetControler(),0,LOCATION_MZONE,nil) then return end
	local tc=Duel.SelectMatchingCard(e:GetHandler():GetControler(),c77239203.atkfilter,e:GetHandler():GetControler(),0,LOCATION_MZONE,1,1,nil)
	local atk=tc:GetFirst():GetAttack()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetOwnerPlayer(tp)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	if a:GetControler()==tp then
		e1:SetValue(atk)
		a:RegisterEffect(e1)
	else
		e1:SetValue(atk)
		d:RegisterEffect(e1)
	end
	e2:SetOwnerPlayer(tp)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	if a:GetControler()==tp then
		e2:SetValue(atk)
		a:RegisterEffect(e2)
	else
		e2:SetValue(atk)
		d:RegisterEffect(e2)
	end   
end