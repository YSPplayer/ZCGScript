--植物的愤怒 人类光辉(ZCG)
function c77239650.initial_effect(c)
    c:EnableCounterPermit(COUNTER_SPELL)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
	
    --add counter
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_COUNTER)	
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetTarget(c77239650.target)	
    e2:SetOperation(c77239650.ctop)
    c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e3)
	
    --coin effect
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e4:SetRange(LOCATION_SZONE)
    e4:SetCode(EVENT_PHASE+PHASE_END)
    e4:SetCountLimit(1)	
    e4:SetCondition(c77239650.con)	
    e4:SetCost(c77239650.cost)	
    e4:SetTarget(c77239650.target1)
    e4:SetOperation(c77239650.activate)
    c:RegisterEffect(e4)	
end
---------------------------------------------------------------------------------
function c77239650.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local tc=eg:GetFirst()
    if chkc then return chkc==tc end
    if chk==0 then return ep~=tp and  tc:IsOnField() end
end
function c77239650.ctop(e,tp,eg,ep,ev,re,r,rp)
    e:GetHandler():AddCounter(COUNTER_SPELL,1)
end
---------------------------------------------------------------------------------
function c77239650.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetCounter(COUNTER_SPELL)>0 end
    local ct=e:GetHandler():GetCounter(COUNTER_SPELL)
    e:SetLabel(ct)
    e:GetHandler():RemoveCounter(tp,COUNTER_SPELL,ct,REASON_COST)
end
function c77239650.con(e,tp,eg,ep,ev,re,r,rp)
    return tp~=Duel.GetTurnPlayer()
end
function c77239650.target1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local ct=e:GetLabel()	
    local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,ct,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c77239650.activate(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
    Duel.Destroy(g,REASON_EFFECT)
end

