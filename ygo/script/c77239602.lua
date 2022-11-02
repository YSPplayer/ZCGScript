--植物の愤怒 魔王树 (ZCG)
local m=77239602
local cm=_G["c"..m]
function c77239602.initial_effect(c)
		aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_PLANT),8,5)
	c:EnableReviveLimit()
---XyzSummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77239602,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c77239602.xyzcon)
	e2:SetOperation(c77239602.xyzop)
	c:RegisterEffect(e2)
   --cannot special summon
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_SPSUMMON_CONDITION)
	e8:SetValue(aux.FALSE)
	c:RegisterEffect(e8)
--lv change
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_XYZ_LEVEL)
	e7:SetProperty(EFFECT_FLAG_SET_AVAIABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetTargetRange(LOCATION_MZONE,0)
	e7:SetTarget(cm.lvtg)
	e7:SetValue(cm.lvval)
	c:RegisterEffect(e7)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c77239602.reptg)
	c:RegisterEffect(e2)
end
function c77239602.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
function c77239602.xyzfilter(c,tp,xyzc)
	return c:IsCanBeXyzMaterial(xyzc) and c:IsType(TYPE_MONSTER)
end
function c77239602.tgfilter(c,tp,xyzc)
	return c:IsSetCard(0xa90) and c:IsType(TYPE_MONSTER)
end
function c77239602.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return false end
	return Duel.IsExistingMatchingCard(c77239602.tgfilter,tp,LOCATION_GRAVE,0,5,nil,tp,c) and Duel.IsExistingMatchingCard(c77239602.xyzfilter,tp,LOCATION_GRAVE,0,5,nil,tp,c)
end
function c77239602.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	local tp=c:GetControler()
	local mg=Duel.SelectMatchingCard(tp,c77239602.xyzfilter,tp,LOCATION_GRAVE,0,5,5,nil,tp,c)
	if mg:GetCount()<0 then return end
	c:SetMaterial(mg)
	Duel.Overlay(c,mg)
end
function cm.lvtg(e,c)
	return c:IsRace(RACE_PLANT) and c:IsType(TYPE_MONSTER)
end
function cm.lvval(e,c,rc)
	local lv=c:GetLevel()
	if rc==e:GetHandler() then return 8
	else return lv end
end






