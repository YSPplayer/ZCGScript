--奥利哈刚 七武神·暗之蚀(ZCG)
function c77240192.initial_effect(c)
    --特殊召唤
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c77240192.spcon)
    c:RegisterEffect(e1)

    --Activate
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetTarget(c77240192.destg)
    e2:SetOperation(c77240192.desop)
    c:RegisterEffect(e2)
end

function c77240192.spfilter(c)
    return c:IsSetCard(0xa50)
end

function c77240192.spcon(e,c)
    if c==nil then return true end
    if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
    local g=Duel.GetMatchingGroup(c77240192.spfilter,c:GetControler(),LOCATION_GRAVE,0,nil)
    local ct=g:GetCount()
    return ct>=7
end

function c77240192.desfilter1(c,rc)
    return c:IsAttribute(rc)
end

function c77240192.desfilter2(c,rc)
    return c:IsType(TYPE_MONSTER) and not c:IsAttribute(ATTRIBUTE_DARK)
end

function c77240192.desfilter3(c,rc)
    return c:IsAttribute(ATTRIBUTE_DARK)
end

function c77240192.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
        Duel.Hint(HINT_SELECTMSG,tp,563)
        local rc=Duel.AnnounceAttribute(tp,1,0xff)
        Duel.SetTargetParam(rc)
        e:GetHandler():SetHint(CHINT_ATTRIBUTE,rc)
        local g=Duel.GetMatchingGroup(c77240192.desfilter1,tp,0,LOCATION_DECK,nil,rc)
        Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
		e:SetLabel(0)
end

function c77240192.desop(e,tp,eg,ep,ev,re,r,rp)
    local rc=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
    local g=Duel.GetMatchingGroup(c77240192.desfilter1,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,nil,rc)
    local g1=Duel.GetMatchingGroup(c77240192.desfilter2,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,nil)
    local g2=Duel.GetMatchingGroup(c77240192.desfilter3,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,nil)
    if g:GetCount()==0 then return end
    local a=g2:GetCount()
    local tc=g:GetMinGroup(Card.GetAttack):GetFirst()
    local atk=0
    atk=tc:GetAttack()*a
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(atk)
	e:GetHandler():RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e:GetHandler():RegisterEffect(e2)
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
end