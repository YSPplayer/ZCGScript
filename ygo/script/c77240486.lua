--奥利哈刚-支配者的庇护 （ZCG）
function c77240486.initial_effect(c)
	  --atk
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e0:SetCode(EVENT_CHAINING)
	e0:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e0:SetRange(LOCATION_DECK)
	e0:SetCondition(c77240486.atkcon)
	e0:SetOperation(c77240486.moop)
	c:RegisterEffect(e0)
 --recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_DECK)
	e1:SetCondition(c77240486.con)
	e1:SetOperation(c77240486.moop)
	c:RegisterEffect(e1)
	 --immune effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetCondition(c77240486.imcon)
	e3:SetValue(c77240486.efilter)
	c:RegisterEffect(e3)
--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,LOCATION_ONFIELD)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetCondition(c77240486.imcon2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)  
	e5:SetType(EFFECT_TYPE_FIELD)  
	e5:SetTargetRange(0,LOCATION_ONFIELD)  
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)  
	e5:SetCondition(c77240486.imcon2)
	e5:SetValue(0x0)  
	c:RegisterEffect(e5)
	 local e6=e5:Clone()
	e6:SetCode(EFFECT_CHANGE_RACE)  
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_CHANGE_TYPE)  
	c:RegisterEffect(e7)
	  local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetRange(LOCATION_SZONE)
	e8:SetTargetRange(0,LOCATION_FZONE)
	e8:SetCode(EFFECT_DISABLE)
	e8:SetCondition(c77240486.imcon3)
	c:RegisterEffect(e8)
  --immune spell
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_SZONE)
	e11:SetValue(c77240486.efilter9)
	c:RegisterEffect(e11)
end
function c77240486.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c77240486.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa70)
end
function c77240486.imcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77240486.cfilter,tp,0,LOCATION_ONFIELD,1,nil)
end
function c77240486.cfilter2(c)
	return c:IsFaceup() and c:IsCode(77239000)
end
function c77240486.imcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77240486.cfilter2,tp,0,LOCATION_ONFIELD,1,nil)
end
function c77240486.cfilter3(c)
	return c:IsFaceup() and c:IsCode(77239002)
end
function c77240486.imcon3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77240486.cfilter3,tp,0,LOCATION_ONFIELD,1,nil)
end
function c77240486.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c77240486.con(e,tp,eg,ep,ev,re,r,rp)
	return ep~=e:GetHandler():GetControler() and eg:IsExists(aux.TRUE,1,nil,tp)
end
function c77240486.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP) and ep==1-tp
end
function c77240486.moop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE,0)>0 then
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
end