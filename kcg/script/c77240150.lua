--殉道者 地狱恋尸虫
function c77240150.initial_effect(c)
    --spsummon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(18063928,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetTarget(c77240150.sptg)
    e1:SetOperation(c77240150.spop)
    c:RegisterEffect(e1)
	
    --deckdes
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DECKDES)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_LEAVE_FIELD)
    --e2:SetCondition(c77240150.decon)
    e2:SetOperation(c77240150.deop)
    c:RegisterEffect(e2)

    --奥利哈刚免疫
    local e9=Effect.CreateEffect(c)
    e9:SetType(EFFECT_TYPE_SINGLE)
    e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e9:SetRange(LOCATION_MZONE)
    e9:SetCode(EFFECT_IMMUNE_EFFECT)
    e9:SetValue(c77240150.efilter9)
    c:RegisterEffect(e9)
    --cannot trigger
    local e11=Effect.CreateEffect(c)
    e11:SetType(EFFECT_TYPE_FIELD)
    e11:SetCode(EFFECT_CANNOT_TRIGGER)
    e11:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
    e11:SetRange(LOCATION_MZONE)
    e11:SetTargetRange(0xa,0xa)
    e11:SetTarget(c77240150.target10)
    c:RegisterEffect(e11)
    --disable
    local e12=Effect.CreateEffect(c)
    e12:SetType(EFFECT_TYPE_FIELD)
    e12:SetCode(EFFECT_DISABLE)
    e12:SetRange(LOCATION_MZONE)
    e12:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
    e12:SetTarget(c77240150.target10)
    c:RegisterEffect(e12)
    --disable effect
    local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e13:SetCode(EVENT_CHAIN_SOLVING)
    e13:SetRange(LOCATION_MZONE)
    e13:SetOperation(c77240150.disop)
    c:RegisterEffect(e13)
end
------------------------------------------------------------------
function c77240150.filter(c,e,tp)
    return c:IsSetCard(0xa60) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c77240150.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c77240150.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c77240150.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c77240150.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end
------------------------------------------------------------------
--[[function c77240150.decon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsPreviousPosition(POS_FACEUP)
end]]
function c77240150.deop(e,tp,eg,ep,ev,re,r,rp)
    local op=0
    op=Duel.SelectOption(tp,aux.Stringid(77240150,0),aux.Stringid(77240150,1))
    if op==0 then
        Duel.DiscardDeck(tp,10,REASON_EFFECT)
	else
        Duel.DiscardDeck(1-tp,10,REASON_EFFECT)
    end
end

function c77240150.efilter9(e,te)
    return te:GetHandler():IsSetCard(0xa50)
end
function c77240150.target10(e,c)
    return c:IsSetCard(0xa50)
end
function c77240150.disop(e,tp,eg,ep,ev,re,r,rp)
    local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
    if tl==LOCATION_SZONE and re:GetHandler():IsSetCard(0xa50) then
        Duel.NegateEffect(ev)
    end
end