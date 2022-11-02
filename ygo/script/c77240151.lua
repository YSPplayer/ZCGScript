local m=77240151
local cm=_G["c"..m]
function c77240151.initial_effect(c)
---Disable  
  local e1=Effect.CreateEffect(c)
  e1:SetDescription(aux.Stringid(m,0)) 
  e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
  e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
  e1:SetType(EFFECT_TYPE_QUICK_O)
  e1:SetCode(EVENT_CHAINING)
  e1:SetRange(LOCATION_MZONE)
  e1:SetCondition(cm.condition1)
  e1:SetCost(cm.cost1)
  e1:SetTarget(cm.target1)
  e1:SetOperation(cm.operation1)
  c:RegisterEffect(e1)
 --disable summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SUMMON)
	e2:SetCondition(cm.condition2)
	e2:SetCost(cm.cost1)
	e2:SetTarget(cm.target2)
	e2:SetOperation(cm.operation2)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringid(m,2))
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
	 local e4=Effect.CreateEffect(c)
	   e4:SetDescription(aux.Stringid(m,3))
	   e4:SetType(EFFECT_TYPE_IGNITION)
	   e4:SetRange(LOCATION_MZONE)
	   e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	   e4:SetCost(cm.spcost)
	   e4:SetTarget(cm.sptg)
	   e4:SetOperation(cm.spop)
	   c:RegisterEffect(e4)
 --immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_ONFIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(cm.efilter9)
	c:RegisterEffect(e3)
--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(cm.distg9)
	c:RegisterEffect(e2)
end
function cm.distg9(e,c)
	return c:IsSetCard(0xa50)
end
function cm.efilter9(e,te)
	return te:GetHandler():IsSetCard(0xa50)
end
function cm.condition1(e,tp,eg,ep,ev,re,r,rp)
	  return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) 
		 and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function cm.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	  if chk==0 then return Duel.CheckLPCost(tp,1000) end
		 Duel.PayLPCost(tp,1000)
end
function cm.target1(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function cm.operation1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function cm.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function cm.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function cm.spfilter(c,e,tp)
	return c:IsSetCard(0xa60) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function cm.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function cm.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
 if chk==0 then return e:GetHandler():IsReleasable() end
  Duel.Release(e:GetHandler(),REASON_COST)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
 and Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
   Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end