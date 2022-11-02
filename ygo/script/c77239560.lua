--时间魔女(ZCG)
function c77239560.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
    --e1:SetHintTiming(0,TIMING_DRAW)
    e1:SetOperation(c77239560.activate)
    e1:SetCondition(c77239560.con)
    c:RegisterEffect(e1)
end
--------------------------------------------------------------
function c77239560.con(e,tp,eg,ep,ev,re,r,rp)
    return tp~=Duel.GetTurnPlayer()
end
function c77239560.activate(e,tp,eg,ep,ev,re,r,rp)
    local e4=Effect.CreateEffect(e:GetHandler())
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetTargetRange(0,1)
    e4:SetCode(EFFECT_SKIP_DP)
    e4:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
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
    local e8=e7:Clone()
    e8:SetCode(EFFECT_CANNOT_BP)
    Duel.RegisterEffect(e8,tp)
    local e9=e8:Clone()
    e9:SetCode(EFFECT_SKIP_BP)
    Duel.RegisterEffect(e9,tp)
    local e10=e9:Clone()
    e10:SetCode(EFFECT_SKIP_M2)
    Duel.RegisterEffect(e10,tp)
end
