--奥利哈刚 埃瑞克特 （ZCG）
function c77239213.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e1)
	   local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e9)
 local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_COPY_INHERIT)
	c:RegisterEffect(e10)
 --atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(77239213,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c77239213.atkcost)
	e4:SetOperation(c77239213.atkop)
	c:RegisterEffect(e4)
 --atkup
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(77239213,1))
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c77239213.spcost)
	e5:SetTarget(c77239213.rectg)
	e5:SetOperation(c77239213.recop)
	c:RegisterEffect(e5)
end
function c77239213.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGrave() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c77239213.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local r=e:GetHandler():GetPreviousAttackOnField()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(r)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,r)
end
function c77239213.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(1-tp,d,REASON_EFFECT)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c77239213.costfilter(c)
	return c:IsSetCard(0xa50) and c:IsAbleToGraveAsCost()
end
function c77239213.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77239213.costfilter,tp,LOCATION_HAND,0,nil) end
	local rg=Duel.SelectMatchingCard(tp,c77239213.costfilter,tp,LOCATION_HAND,0,1,99,nil)
	e:SetLabel(#rg)
	Duel.SendtoGrave(rg,REASON_COST+REASON_DISCARD)
end
function c77239213.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local g=e:GetLabel()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(g*1000)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD)
	c:RegisterEffect(e1)
end