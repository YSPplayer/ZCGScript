--殉道者 精灵蛇（ZCG）
local m=77240160
local cm=_G["c"..m]
function c77240160.initial_effect(c)
		c:EnableCounterPermit(0x141c)
 --spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77240160,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c77240160.sptg)
	e1:SetOperation(c77240160.acop)
	c:RegisterEffect(e1)
 --negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(77240160,1))
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c77240160.condition3)
	e4:SetCost(c77240160.cost3)
	e4:SetTarget(c77240160.target3)
	e4:SetOperation(c77240160.operation3)
	c:RegisterEffect(e4)
--negate attack
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(77240160,2))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c77240160.condition4)
	e5:SetCost(c77240160.cost4)
	e5:SetOperation(c77240160.operation4)
	c:RegisterEffect(e5)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c77240160.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e12:SetTarget(c77240160.distg9)
	c:RegisterEffect(e12)
end
function c77240160.distg9(e,c)
	return c:IsSetCard(0xa50) 
end
function c77240160.efilter9(e,te)
	return te:GetHandler():IsSetCard(0xa50)
end
function c77240160.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,LOCATION_GRAVE)>0 end
end
function c77240160.acop(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,LOCATION_GRAVE)
		e:GetHandler():AddCounter(0x141c,dam)
end
function c77240160.condition3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and not c:IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c77240160.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x141c,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x141c,1,REASON_COST)
end
function c77240160.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c77240160.operation3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c77240160.condition4(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c77240160.cost4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x141c,1,REASON_COST) end
	   e:GetHandler():RemoveCounter(tp,0x141c,1,REASON_COST)
end
function c77240160.target4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c77240160.operation4(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
