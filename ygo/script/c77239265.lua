--奥利哈刚第五层结界操控阵 （ZCG）
function c77239265.initial_effect(c)
					--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(77239265,0))
	e0:SetType(EFFECT_TYPE_IGNITION)
	e0:SetRange(LOCATION_HAND)
	e0:SetTarget(c77239265.cotg)
	e0:SetOperation(c77239265.coop)
	c:RegisterEffect(e0)
		 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77239265,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c77239265.condition)
	e1:SetOperation(c77239265.moop)
	c:RegisterEffect(e1)
		--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77239265,2))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c77239265.condition)
	e2:SetTarget(c77239265.motg)
	e2:SetOperation(c77239265.moop2)
	c:RegisterEffect(e2)
	--selfdes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c77239265.sdcon2)
	e4:SetOperation(c77239265.sdop)
	c:RegisterEffect(e4)
		--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(77239265,3))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_ONFIELD)
	e3:SetTarget(c77239265.rmtg)
	e3:SetOperation(c77239265.rmop)
	c:RegisterEffect(e3)
		--Activate
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(77239265,4))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_ONFIELD)
	e9:SetCost(c77239265.descost2)
	e9:SetTarget(c77239265.adtg)
	e9:SetOperation(c77239265.adop)
	c:RegisterEffect(e9)
  --
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetCondition(c77239265.imcon)
	e5:SetValue(c77239265.atkval)
	c:RegisterEffect(e5)
 --cannot trigger
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_CANNOT_TRIGGER)
	e8:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e8:SetRange(LOCATION_ONFIELD)
	e8:SetTargetRange(0,0xa)
	e8:SetCondition(c77239265.imcon)
	e8:SetTarget(c77239265.distg)
	c:RegisterEffect(e8)
	--immune spell
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_ONFIELD)
	e11:SetValue(c77239265.efilter9)
	c:RegisterEffect(e11)
end
function c77239265.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,Duel.GetLP(tp)-1) end
	Duel.PayLPCost(tp,Duel.GetLP(tp)-1)
end
function c77239265.tgfilter(c)
	return c:IsFaceup()
end
function c77239265.adtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77239265.tgfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil) end
end
function c77239265.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local g=Duel.SelectMatchingCard(tp,c77239265.tgfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c77239265.efilter9(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c77239265.distg(e,c)
	return c:IsType(TYPE_FIELD)
end
function c77239265.cfilter9(c)
	return c:IsFaceup() and c:IsSetCard(0xa50) and c:IsType(TYPE_SPELL)
end
function c77239265.imcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77239265.cfilter9,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c77239265.atkfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c77239265.atkval(e,c)
	return Duel.GetMatchingGroupCount(c77239265.atkfilter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*500
end
function c77239265.refilter(c)
return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end 
function c77239265.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77239265.refilter,e:GetHandler():GetControler(),0,LOCATION_ONFIELD+LOCATION_HAND,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c77239265.refilter,e:GetHandler():GetControler(),0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,ct,tp,LOCATION_DECK+LOCATION_HAND)
end
function c77239265.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroup(c77239265.refilter,e:GetHandler():GetControler(),0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	if #ct>0 then
	local rev=Duel.Remove(ct,POS_FACEUP,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Recover(tp,rev*500,REASON_EFFECT)
	end
end
function c77239265.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(77239265)==0
end
function c77239265.sdop(e,tp,eg,ep,ev,re,r,rp) 
	e:GetHandler():CopyEffect(77239264,RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterFlagEffect(77239265,RESET_EVENT+0x1fe0000,0,1)
end
function c77239265.cfilter1(c)
return c:IsFaceup() and c:IsCode(77239261)
end
function c77239265.cfilter2(c)
return c:IsFaceup() and c:IsCode(77239262)
end
function c77239265.cfilter3(c)
return c:IsFaceup() and c:IsCode(77239263)
end
function c77239265.cfilter3(c)
return c:IsFaceup() and c:IsCode(77239264)
end
function c77239265.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77239265.cfilter1,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c77239265.cfilter2,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c77239265.cfilter3,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c77239265.cfilter4,tp,LOCATION_ONFIELD,0,1,nil)
end
function c77239265.motg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>0 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>1 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) end
end
function c77239265.moop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
end
function c77239265.moop2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>0 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>1 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) then
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
end
function c77239265.filter1(c)
return c:IsCode(77239261)
end
function c77239265.filter2(c)
return c:IsCode(77239262)
end
function c77239265.filter3(c)
return c:IsCode(77239263)
end
function c77239265.filter4(c)
return c:IsCode(77239264)
end
function c77239265.cotg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=3 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=4 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) and Duel.IsExistingMatchingCard(c77239265.filter1,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,1,nil) and Duel.IsExistingMatchingCard(c77239265.filter2,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,1,nil) and Duel.IsExistingMatchingCard(c77239265.filter3,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,1,nil) and Duel.IsExistingMatchingCard(c77239265.filter4,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,1,nil) end
end 
function c77239265.coop(e,tp,eg,ep,ev,re,r,rp,chk)
	if (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=3 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=4 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) then
	local g1=Duel.GetMatchingGroup(c77239265.filter1,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c77239265.filter2,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil)
	local g3=Duel.GetMatchingGroup(c77239265.filter3,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil)
	local g4=Duel.GetMatchingGroup(c77239265.filter4,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil)
	Duel.MoveToField(g1:GetFirst(),tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	Duel.MoveToField(g2:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.MoveToField(g3:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.MoveToField(g4:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
end