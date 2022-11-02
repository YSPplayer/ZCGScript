--殉道者 变异魔人（ZCG）
local m=77239316
local cm=_G["c"..m]
function c77239316.initial_effect(c)
  c:EnableReviveLimit()
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.FALSE)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
		 e1:SetDescription(aux.Stringid(m,0))
		 e1:SetType(EFFECT_TYPE_FIELD)
		 e1:SetCode(EFFECT_SPSUMMON_PROC)
		 e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		 e1:SetRange(LOCATION_HAND)
		 e1:SetCondition(cm.spcon)
		 e1:SetOperation(cm.spop)
		 c:RegisterEffect(e1)
	 local e2=Effect.CreateEffect(c)
		   e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		   e2:SetCode(EVENT_SPSUMMON_SUCCESS)
		   e2:SetTarget(cm.retg)
		   e2:SetOperation(cm.reop)
		   c:RegisterEffect(e2)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(cm.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e12:SetTarget(cm.distg9)
	c:RegisterEffect(e12)
end
function cm.distg9(e,c)
	return c:IsSetCard(0xa50)
end
function cm.efilter9(e,te)
	return te:GetHandler():IsSetCard(0xa50)
end
function cm.spfilter(c,ft)
	return c:IsFaceup() and c:IsAbleToRemoveAsCost() and (ft>0 or c:GetSequence()<5) and c:IsSetCard(0xa60)
end
function cm.spcon(e,c)
if c==nil then return true end
 local tp=c:GetControler()
 local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
return ft>-1 and Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ft)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c)
	  local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,ft)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function cm.retg(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
	   local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,e:GetHandler())
	   Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	   Duel.SetChainLimit(aux.FALSE)
end
function cm.reop(e,tp,eg,ep,ev,re,r,rp)
	 local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,aux.ExceptThisCard(e))
	 Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
