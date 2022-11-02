--奥利哈刚 灵魂操控者 （ZCG）
function c77239211.initial_effect(c)
		--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77239211,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c77239211.target)
	e1:SetOperation(c77239211.operation)
	c:RegisterEffect(e1)
 --turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77239211,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c77239211.target2)
	e2:SetOperation(c77239211.operation2)
	c:RegisterEffect(e2)
end
function c77239211.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(77239211)==0 end
	c:RegisterFlagEffect(77239211,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c77239211.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c77239211.atfilter(c)
return c:IsFaceup() and c:IsAttackPos() 
end 
function c77239211.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c77239211.atfilter,tp,0,LOCATION_MZONE,nil)>0 end   
end
function c77239211.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c77239211.atfilter,tp,0,LOCATION_MZONE,1,1,nil)
	local ag=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	Group.RemoveCard(ag,g)
	if ag:GetCount()<=0 then return end
	local g2=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,g)
	local tc2=g2:GetFirst()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2)
	Duel.CalculateDamage(g:GetFirst(),g2:GetFirst())
end