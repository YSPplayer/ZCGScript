--奥利哈刚 蓝光蛇 （ZCG）
function c77239228.initial_effect(c)
	   --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77239228,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c77239228.condition)
	e1:SetTarget(c77239228.target)
	e1:SetOperation(c77239228.operation)
	c:RegisterEffect(e1)
end
function c77239228.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(EVENT_DESTROYED)
end
function c77239228.filter(c,e,tp)
	return c:IsCode(77239228) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c77239228.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c77239228.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c77239228.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>=2 then ft=2 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c77239228.filter,tp,LOCATION_DECK,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		local t1=g:GetFirst()
		local t2=g:GetNext()
		Duel.SpecialSummonStep(t1,0,tp,tp,false,false,POS_FACEUP)
		if t2 then
			Duel.SpecialSummonStep(t2,0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.SpecialSummonComplete()
	end
end