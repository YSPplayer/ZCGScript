--奥利哈刚 无限追击(ZCG)
function c77239247.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCondition(c77239247.condition)	
	e1:SetTarget(c77239247.target)
	e1:SetOperation(c77239247.activate)
	c:RegisterEffect(e1)
end
function c77239247.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetCurrentPhase()==PHASE_MAIN2 and Duel.GetTurnPlayer()==tp
end
function c77239247.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c77239247.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c77239247.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c77239247.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c77239247.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c77239247.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e10=Effect.CreateEffect(e:GetHandler())
        e10:SetType(EFFECT_TYPE_SINGLE)
        e10:SetCode(EFFECT_UPDATE_ATTACK)
        e10:SetValue(500)
        e10:SetReset(RESET_EVENT+0x1ff0000)		
		tc:RegisterEffect(e10)
		Duel.SpecialSummonComplete()
	end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_SKIP_TURN)
    e1:SetTargetRange(0,1)
    e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
    Duel.RegisterEffect(e1,tp)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetTargetRange(1,0)
    e2:SetCode(EFFECT_SKIP_M2)
    e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
    Duel.RegisterEffect(e2,tp)
    local e3=e2:Clone()
    e3:SetCode(EFFECT_CANNOT_EP)
    Duel.RegisterEffect(e3,tp)			
    local e4=Effect.CreateEffect(e:GetHandler())
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetTargetRange(1,0)
    e4:SetCode(EFFECT_SKIP_DP)
    e4:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
    Duel.RegisterEffect(e4,tp)
    local e5=e4:Clone()
    e5:SetCode(EFFECT_SKIP_SP)
    Duel.RegisterEffect(e5,tp)
    local e6=e5:Clone()
    e6:SetCode(EFFECT_SKIP_M1)
    Duel.RegisterEffect(e6,tp)	
    local e7=e6:Clone()
    e7:SetCode(EFFECT_CANNOT_EP)
    Duel.RegisterEffect(e7,tp)	
end
