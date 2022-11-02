--奥利哈刚的元素 （ZCG）
function c77239248.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	 --Cost Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LPCOST_CHANGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(c77239248.costchange)
	c:RegisterEffect(e2)
--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetValue(c77239248.atkval)
	c:RegisterEffect(e5)
--recover
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(77239248,0))
	e3:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c77239248.target)
	e3:SetOperation(c77239248.activate)
	c:RegisterEffect(e3)
 --spsummon
	local e9=Effect.CreateEffect(c)
	e9:SetCategory(CATEGORY_TOHAND)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e9:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e9:SetCode(EVENT_LEAVE_FIELD)
	e9:SetCondition(c77239248.spcon2)
	e9:SetTarget(c77239248.rettg)
	e9:SetOperation(c77239248.retop)
	c:RegisterEffect(e9)

end
function c77239248.costchange(e,re,rp,val)
 if re then
		return 0
	else
		return val
	end
end
function c77239248.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c77239248.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c77239248.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end
function c77239248.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) or Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_DECK,3,nil)  end
	local g1=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	local g2=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_DECK,nil)
	if #g1>0 and #g2>2 then
		local opt=Duel.SelectOption(1-tp,aux.Stringid(77239248,1),aux.Stringid(c77239248,2))
		e:SetLabel(opt)
		if opt==0 then
		local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_DECK,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,3,0,0)
		elseif opt==1 then
		local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	elseif #g1>0 and #g2<=2 then
	 local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
   elseif #g1<=0 and #g2>2 then
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_DECK,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,3,0,0)
end
end
end
function c77239248.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	local g2=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_DECK,nil)
	if #g1>0 and #g2>2 then
		if e:GetLabel()==0  then
		local sg=g2:RandomSelect(1-tp,3) 
		Duel.SendtoGrave(sg,REASON_DISCARD)
		elseif e:GetLabel()==1 then
		Duel.Destroy(g1,REASON_EFFECT) 
   elseif #g1>0 and #g2<=2 then
		Duel.Destroy(g1,REASON_EFFECT) 
   elseif #g1<=0 and #g2>2 then
		local sg=g2:RandomSelect(1-tp,3) 
		Duel.SendtoGrave(sg,REASON_DISCARD)
	end
end
end
function c77239248.atkval(e,c)
	return Duel.GetMatchingGroupCount(aux.TRUE,c:GetControler(),0,LOCATION_ONFIELD,nil)*500
end