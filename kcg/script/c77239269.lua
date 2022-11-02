--达姿的第二仪式(ZCG)
function c77239269.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c77239269.cost)
    e1:SetTarget(c77239269.target)
    e1:SetOperation(c77239269.activate)
    c:RegisterEffect(e1)
end

function c77239269.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetLP(tp,1)
end
function c77239269.filter(c,e,tp)
    return c:IsCode(77239292) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c77239269.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c77239269.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
end
function c77239269.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    --Duel.SetLP(tp,1)	
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)	
    local g=Duel.SelectMatchingCard(tp,c77239269.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
    --local tc=g:GetFirst()   
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
        --tc:CompleteProcedure()		
    end	
	if Duel.GetMatchingGroupCount(c77239269.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,nil)>0 and
	Duel.GetMatchingGroupCount(c77239269.filter3,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,nil)>0 and
	Duel.GetMatchingGroupCount(c77239269.filter4,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,nil)>0 then   
		Duel.Win(tp,0x20)		
	end
    if c:IsRelateToEffect(e) then
	    Duel.BreakEffect()
        c:CancelToGrave()
        Duel.SendtoHand(c,nil,REASON_EFFECT)		
    end
end
function c77239269.filter2(c)
    return c:IsCode(77239253)
end
function c77239269.filter3(c)
    return c:IsCode(77239230)
end
function c77239269.filter4(c)
    return c:IsCode(77239280)
end

