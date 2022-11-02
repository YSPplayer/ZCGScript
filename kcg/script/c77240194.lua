--奥利哈刚 七武神·水之伤(ZCG)
function c77240194.initial_effect(c)
    --特殊召唤
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c77240194.spcon)
    c:RegisterEffect(e1)

    --atk down
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(0,LOCATION_MZONE)
    e2:SetTarget(c77240194.tg)
    e2:SetValue(c77240194.atkval)
    c:RegisterEffect(e2)

    --def down
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_UPDATE_DEFENSE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetTargetRange(0,LOCATION_MZONE)
    e3:SetTarget(c77240194.tg)
    e3:SetValue(c77240194.defval)
    c:RegisterEffect(e3)

    --destroy
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_SELF_DESTROY)
    e4:SetRange(LOCATION_MZONE)
    e4:SetTargetRange(0,LOCATION_MZONE)
    e4:SetTarget(c77240194.destarget)
    c:RegisterEffect(e4)

    --attack
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetOperation(c77240194.op)
	c:RegisterEffect(e5)

    --remove
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_BATTLED)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetOperation(c77240194.activate)
	c:RegisterEffect(e6)
end

function c77240194.spfilter(c)
    return c:IsSetCard(0xa50)
end

function c77240194.spcon(e,c)
    if c==nil then return true end
    if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
    local g=Duel.GetMatchingGroup(c77240194.spfilter,c:GetControler(),LOCATION_GRAVE,0,nil)
    local ct=g:GetCount()
    return ct>=7
end

function c77240194.tg(e,c)
    return c:IsFaceup() and not c:IsAttribute(ATTRIBUTE_WATER)
end

function c77240194.destarget(e,c)
    return c:IsType(TYPE_MONSTER) and c:IsFaceup() and (c:GetAttack()==0 or c:GetDefense()==0) and not c:IsAttribute(ATTRIBUTE_WATER)
end

function c77240194.op(e,tp,eg,ep,ev,re,r,rp,c)
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c77240194.atkvalue)
	e:GetHandler():RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c77240194.defvalue)
	e:GetHandler():RegisterEffect(e2)
end

function c77240194.dragfilter1(c)
	return c:IsType(TYPE_MONSTER)
end

function c77240194.dragfilter2(c,rc)
    return c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_WATER)
end

function c77240194.atkvalue(e)
	local g=Duel.GetMatchingGroup(c77240194.dragfilter1,e:GetHandler():GetControler(),0,LOCATION_MZONE,nil)
	local tatk=0
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetAttack()
		tatk=tatk+atk
		tc=g:GetNext()
	end
	return tatk*2
end

function c77240194.defvalue(e)
	local g=Duel.GetMatchingGroup(c77240194.dragfilter1,e:GetHandler():GetControler(),0,LOCATION_MZONE,nil)
	local tdef=0
	local tc=g:GetFirst()
	while tc do
		local def=tc:GetDefense()
		tdef=tdef+def
		tc=g:GetNext()
	end
	return tdef*2
end

function c77240194.atkval(e)
	local g=Duel.GetMatchingGroup(c77240194.dragfilter2,e:GetHandler():GetControler(),0,LOCATION_MZONE,nil)
	local tatk=0
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetAttack()
		tatk=tatk+atk
		tc=g:GetNext()
	end
	return -tatk
end

function c77240194.defval(e)
	local g=Duel.GetMatchingGroup(c77240194.dragfilter2,e:GetHandler():GetControler(),0,LOCATION_MZONE,nil)
	local tdef=0
	local tc=g:GetFirst()
	while tc do
		local def=tc:GetDefense()
		tdef=tdef+def
		tc=g:GetNext()
	end
	return -tdef
end

function c77240194.desfilter(c,rc)
    return c:IsType(TYPE_MONSTER) and not c:IsAttribute(ATTRIBUTE_WATER)
end

function c77240194.activate(e,tp,eg,ep,ev,re,r,rp,c)
    local g1=Duel.GetMatchingGroup(c77240194.desfilter,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,nil)
    Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
end