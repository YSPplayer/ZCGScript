--六芒星之龙 黑海霸龙 （ZCG）
function c77240238.initial_effect(c)
	  --summon with 2 tribute or 1 setcard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77240238,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c77240238.ttcon)
	e1:SetOperation(c77240238.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
--cannot target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
 --summon
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e7)
 --ATK Up
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(aux.bdocon)
	e4:SetTarget(c77240238.drtg)
	e4:SetOperation(c77240238.drop)
	c:RegisterEffect(e4)
end
function c77240238.filter9(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
end
function c77240238.sprfilter(c)
	return  c:IsType(TYPE_MONSTER)
end
function c77240238.fselect(g)
	return g:GetClassCount(Card.GetAttribute)==#g
end
function c77240238.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	-- local g=Duel.GetMatchingGroup(c77240238.filter9,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil,e)
   --  if chkc then return c77240238.filter9(chkc,e) end
   -- if chk==0 then return g:GetClassCount(Card.GetLinkAttribute)>=5 end
	local rg=Duel.GetMatchingGroup(c77240238.sprfilter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	return rg:CheckSubGroup(c77240238.fselect,5,5)
end
function c77240238.drop(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
   --- local g=Duel.GetMatchingGroup(c77240238.costfilter1,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil,e)
	if Duel.SelectYesNo(tp,aux.Stringid(77240238,3)) then
		 local rg=Duel.GetMatchingGroup(c77240238.sprfilter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=rg:SelectSubGroup(tp,c77240238.fselect,true,5,5,tp)
	if sg then
	   if Duel.SetTargetCard(sg) and Duel.Destroy(sg,REASON_EFFECT)~=0  and hg>0 then
		 Duel.BreakEffect()
		 Duel.ConfirmCards(tp,hg)
		 Duel.SendtoDeck(hg,nil,2,REASON_EFFECT)
		 Duel.ShuffleDeck(1-tp)
		 Duel.Draw(1-tp,hg:GetCount(),REASON_EFFECT)
	end
end
end
end
function c77240238.otfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK)
end
function c77240238.tfilter(c)
	return c:IsSetCard(0xa70)
end
function c77240238.ttcon(e,c,minc)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c77240238.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local mg2=Duel.GetMatchingGroup(c77240238.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return (minc<=2 and Duel.CheckTribute(c,2,2,mg)) or (minc<=1 and Duel.CheckTribute(c,1,1,mg2))
end
function c77240238.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	if not Duel.IsExistingMatchingCard(c77240238.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and Duel.IsExistingMatchingCard(c77240238.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c77240238.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
	elseif Duel.IsExistingMatchingCard(c77240238.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and not Duel.IsExistingMatchingCard(c77240238.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c77240238.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local opt=Duel.SelectOption(tp,aux.Stringid(77240238,1),aux.Stringid(77240238,2))
	e:SetLabel(opt)
	if opt==0 then 
	local mg=Duel.GetMatchingGroup(c77240238.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local mg=Duel.GetMatchingGroup(c77240238.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
end
end