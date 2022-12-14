--长颈龙真红进化(ZCG)
function c77238795.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCondition(c77238795.condition)	
    e1:SetTarget(c77238795.target)
    e1:SetOperation(c77238795.activate)
    c:RegisterEffect(e1)
end
function c77238795.cfilter(c)
    return c:IsFaceup() and c:IsCode(77238789)
end
function c77238795.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c77238795.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c77238795.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
        and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c77238795.activate(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
    local token=Duel.CreateToken(tp,77238789)
    Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CANNOT_ATTACK)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    token:RegisterEffect(e1,true)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_DISABLE)
    e2:SetReset(RESET_EVENT+0x1fe0000)
    token:RegisterEffect(e2,true)
    local e3=Effect.CreateEffect(e:GetHandler())
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_DISABLE_EFFECT)
    e3:SetReset(RESET_EVENT+0x1fe0000)
    token:RegisterEffect(e3,true)
    local e4=Effect.CreateEffect(e:GetHandler())
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_CANNOT_ATTACK)
    e4:SetReset(RESET_EVENT+0x1fe0000)
    token:RegisterEffect(e4,true)
    local e5=Effect.CreateEffect(e:GetHandler())
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
    e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e5:SetValue(1)
    token:RegisterEffect(e5,true)
	
    local token1=Duel.CreateToken(tp,77238789)
    Duel.SpecialSummon(token1,0,tp,tp,false,false,POS_FACEUP)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CANNOT_ATTACK)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    token1:RegisterEffect(e1,true)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_DISABLE)
    e2:SetReset(RESET_EVENT+0x1fe0000)
    token1:RegisterEffect(e2,true)
    local e3=Effect.CreateEffect(e:GetHandler())
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_DISABLE_EFFECT)
    e3:SetReset(RESET_EVENT+0x1fe0000)
    token1:RegisterEffect(e3,true)	
    local e4=Effect.CreateEffect(e:GetHandler())
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_CANNOT_ATTACK)
    e4:SetReset(RESET_EVENT+0x1fe0000)
    token1:RegisterEffect(e4,true)	
    local e5=Effect.CreateEffect(e:GetHandler())
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
    e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e5:SetValue(1)
    token1:RegisterEffect(e5,true)
end
