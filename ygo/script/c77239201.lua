--奥利哈刚 蕾欧丝 （ZCG）
function c77239201.initial_effect(c)
 --pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
		--spsummon2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710401,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(aux.bdocon)
	e3:SetOperation(c77239201.op)
	c:RegisterEffect(e3)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710401,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c77239201.spcost)
	e2:SetTarget(c77239201.sptg)
	e2:SetOperation(c77239201.spop)
	c:RegisterEffect(e2)
end
function c77239201.op(e,tp,eg,ep,ev,re,r,rp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_SKIP_M1)
		e1:SetTargetRange(0,1)
		e1:SetReset(RESET_PHASE+PHASE_MAIN1+RESET_SELF_TURN)
		Duel.RegisterEffect(e1,tp)
end
function c77239201.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c77239201.filter(c,e,tp)
	return c:IsCode(77239204) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c77239201.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c77239201.filter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK)
end
function c77239201.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c77239201.filter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK,LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end

