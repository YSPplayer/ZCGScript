--奥利哈刚 七武神·地之御(ZCG)
function c77240193.initial_effect(c)
    --特殊召唤
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c77240193.spcon)
    c:RegisterEffect(e1)

    --untargetable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c77240193.atlimit)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c77240193.tglimit)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)

    --attack
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetOperation(c77240193.op)
	c:RegisterEffect(e4)

    --remove
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_BATTLED)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetOperation(c77240193.activate)
	c:RegisterEffect(e5)
end

function c77240193.spfilter(c)
    return c:IsSetCard(0xa50)
end

function c77240193.spcon(e,c)
    if c==nil then return true end
    if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
    local g=Duel.GetMatchingGroup(c77240193.spfilter,c:GetControler(),LOCATION_GRAVE,0,nil)
    local ct=g:GetCount()
    return ct>=7
end

function c77240193.atlimit(e,c)
	return c:IsFaceup() and c~=e:GetHandler()
end

function c77240193.tglimit(e,c)
	return c~=e:GetHandler()
end

function c77240193.op(e,tp,eg,ep,ev,re,r,rp,c)
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c77240193.atkvalue)
	e:GetHandler():RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c77240193.defvalue)
	e:GetHandler():RegisterEffect(e2)
end

function c77240193.dragfilter(c)
	return c:IsType(TYPE_MONSTER)
end

function c77240193.atkvalue(e)
	local g=Duel.GetMatchingGroup(c77240193.dragfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)
	local tatk=0
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetAttack()
		tatk=tatk+atk
		tc=g:GetNext()
	end
	return tatk*2
end

function c77240193.defvalue(e)
	local g=Duel.GetMatchingGroup(c77240193.dragfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)
	local tdef=0
	local tc=g:GetFirst()
	while tc do
		local def=tc:GetDefense()
		tdef=tdef+def
		tc=g:GetNext()
	end
	return tdef*2
end

function c77240193.desfilter(c,rc)
    return c:IsType(TYPE_MONSTER) and not c:IsAttribute(ATTRIBUTE_EARTH)
end

function c77240193.activate(e,tp,eg,ep,ev,re,r,rp,c)
    local g1=Duel.GetMatchingGroup(c77240193.desfilter,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,nil)
    Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
end