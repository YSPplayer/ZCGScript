--真红眼闪光龙
function c77238782.initial_effect(c)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c77238782.spcon)
    c:RegisterEffect(e1)

    --battle indestructable
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e2:SetValue(1)
    c:RegisterEffect(e2)	
	
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
    e4:SetCondition(c77238782.damcon)
    e4:SetOperation(c77238782.damop)
    c:RegisterEffect(e4)
	--direct attack
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_DIRECT_ATTACK)
    e3:SetCondition(c77238782.con)	
    c:RegisterEffect(e3)
	
    --spsumon
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(77238782,1))
	e5:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
    e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCode(EVENT_PHASE+PHASE_END)
    e5:SetCountLimit(1)
    e5:SetTarget(c77238782.target)
    e5:SetOperation(c77238782.activate)
    c:RegisterEffect(e5)	
end
--------------------------------------------------------------------
function c77238782.spcon(e,c)
    if c==nil then return true end
    return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
--------------------------------------------------------------------
function c77238782.spfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x3b)
end
function c77238782.damcon(e,tp,eg,ep,ev,re,r,rp)
    return ep~=tp and Duel.IsExistingMatchingCard(c77238782.spfilter,c:GetControler(),LOCATION_MZONE,0,3,nil)
	    and Duel.GetAttackTarget()==nil
end
function c77238782.damop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ChangeBattleDamage(ep,Duel.GetLP(1-tp))
end
function c77238782.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c77238782.spfilter,c:GetControler(),LOCATION_MZONE,0,3,nil)
end
--------------------------------------------------------------------
function c77238782.filter(c,e,tp)
    return c:IsSetCard(0x3b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c77238782.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c77238782.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c77238782.activate(e,tp,eg,ep,ev,re,r,rp)
    local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c77238782.filter,tp,LOCATION_HAND+LOCATION_DECK,0,ft,ft,nil,e,tp)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end



