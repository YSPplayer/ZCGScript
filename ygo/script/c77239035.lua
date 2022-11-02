--神的援助(ZCG)
function c77239035.initial_effect(c)
    --Activate(summon)
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(77239035,0))	
    e1:SetCategory(CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetTarget(c77239035.target)
    e1:SetOperation(c77239035.activate)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(77239035,0))		
    e2:SetCategory(CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_ACTIVATE)
    e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    e2:SetTarget(c77239035.target)
    e2:SetOperation(c77239035.activate)
    c:RegisterEffect(e2)
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(77239035,0))		
    e3:SetCategory(CATEGORY_DESTROY)
    e3:SetType(EFFECT_TYPE_ACTIVATE)
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    e3:SetTarget(c77239035.target)
    e3:SetOperation(c77239035.activate)
    c:RegisterEffect(e3)

    --Activate(summon)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(77239035,1))	
    e4:SetCategory(CATEGORY_DESTROY)
    e4:SetType(EFFECT_TYPE_ACTIVATE)
    e4:SetCode(EVENT_SUMMON_SUCCESS)
    e4:SetTarget(c77239035.target1)
    e4:SetOperation(c77239035.activate1)
    c:RegisterEffect(e4)
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(77239035,1))		
    e5:SetCategory(CATEGORY_DESTROY)
    e5:SetType(EFFECT_TYPE_ACTIVATE)
    e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    e5:SetTarget(c77239035.target1)
    e5:SetOperation(c77239035.activate1)
    c:RegisterEffect(e5)
    local e6=Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(77239035,1))		
    e6:SetCategory(CATEGORY_DESTROY)
    e6:SetType(EFFECT_TYPE_ACTIVATE)
    e6:SetCode(EVENT_SPSUMMON_SUCCESS)
    e6:SetTarget(c77239035.target1)
    e6:SetOperation(c77239035.activate1)
    c:RegisterEffect(e6)	
end
-------------------------------------------------------------------------------
function c77239035.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return ep~=tp and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
    local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c77239035.activate(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
    if g:GetCount()>0 then
        Duel.Destroy(g,REASON_EFFECT)
    end
end
-------------------------------------------------------------------------------
function c77239035.filter(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c77239035.target1(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return ep~=tp and Duel.IsExistingMatchingCard(c77239035.filter,tp,0,LOCATION_ONFIELD,1,c) end
    local sg=Duel.GetMatchingGroup(c77239035.filter,tp,0,LOCATION_ONFIELD,c)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c77239035.activate1(e,tp,eg,ep,ev,re,r,rp)
    local sg=Duel.GetMatchingGroup(c77239035.filter,tp,0,LOCATION_ONFIELD,e:GetHandler())
    Duel.Destroy(sg,REASON_EFFECT)
end


