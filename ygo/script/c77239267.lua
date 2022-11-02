--奥利哈刚之圣都 亚特兰提斯2 （ZCG）
function c77239267.initial_effect(c)
		c:EnableCounterPermit(0x551)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c77239267.operation)
	c:RegisterEffect(e1)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_IMMUNE_EFFECT)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetRange(LOCATION_FZONE)
	e0:SetValue(c77239267.efilter)
	c:RegisterEffect(e0)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c77239267.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_MSET)
	c:RegisterEffect(e4)
	local e5=e2:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e11=e2:Clone()
	e11:SetCode(EVENT_SSET)
	c:RegisterEffect(e11)
	--Add counter
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e6:SetCode(EVENT_CHAIN_SOLVING)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetRange(LOCATION_FZONE)
	e6:SetOperation(c77239267.op)
	c:RegisterEffect(e6)
  --destroy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(77239267,0))
	e7:SetCategory(CATEGORY_TOHAND)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_FZONE)
	e7:SetCountLimit(1,77239267)
	e7:SetCost(c77239267.descost)
	e7:SetTarget(c77239267.thtg2)
	e7:SetOperation(c77239267.thop2)
	c:RegisterEffect(e7)
--destroy
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(77239267,1))
	e8:SetCategory(CATEGORY_DESTROY)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetRange(LOCATION_FZONE)
	e8:SetCountLimit(1,77239267)
	e8:SetCost(c77239267.descost2)
	e8:SetTarget(c77239267.target2)
	e8:SetOperation(c77239267.activate2)
	c:RegisterEffect(e8)
--destroy
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(77239267,2))
	e9:SetCategory(CATEGORY_DESTROY)
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_FZONE)
	e9:SetCountLimit(1,77239267)
	e9:SetCost(c77239267.descost2)
	e9:SetTarget(c77239267.target)
	e9:SetOperation(c77239267.activate)
	c:RegisterEffect(e9)
		--Activate
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(77239267,3))
	e10:SetCategory(CATEGORY_DECKDES)
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetRange(LOCATION_FZONE)
	e10:SetCountLimit(1,77239267)
	e10:SetCost(c77239267.descost3)
	e10:SetTarget(c77239267.target9)
	e10:SetOperation(c77239267.operation9)
	c:RegisterEffect(e10)
end
function c77239267.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c77239267.descost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x551,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x551,3,REASON_COST)
end
function c77239267.target9(e,tp,eg,ep,ev,re,r,rp,chk)
	 local ct=math.floor(Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)/2)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,e:GetHandler():GetControler(),0,LOCATION_DECK,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDE,nil,0,1-tp,ct)
end
function c77239267.operation9(e,tp,eg,ep,ev,re,r,rp)
local ct=math.floor(Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)/2)
	Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
end
function c77239267.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x551,2,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x551,2,REASON_COST)
end
function c77239267.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c77239267.activate2(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(sg,REASON_EFFECT) 
end
function c77239267.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_HAND,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c77239267.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_HAND,nil)
	Duel.Destroy(sg,REASON_EFFECT) 
end
function c77239267.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x551,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x551,1,REASON_COST)
end
function c77239267.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c77239267.filter,tp,LOCATION_DECK,0,1,nil) and Duel.IsExistingTarget(c77239267.filter,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingTarget(c77239267.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,3,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
end
function c77239267.filter(c)
	return c:IsAbleToHand()
end
function c77239267.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local t1=Duel.SelectMatchingCard(tp,c77239267.filter,tp,LOCATION_DECK,0,1,1,nil)
	if not t1 then return end
	local t2=Duel.SelectMatchingCard(tp,c77239267.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if not t2 then return end
	local t3=Duel.SelectMatchingCard(tp,c77239267.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	if not t3 then return end
	local g=Group.FromCards(t1,t2,t3)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
function c77239267.op(e,tp,eg,ep,ev,re,r,rp)
	local c=re:GetHandler()
	if  c~=e:GetHandler() then
		e:GetHandler():AddCounter(0x551,1)
	end
end
function c77239267.operation(e,tp,eg,ep,ev,re,r,rp)
		  e:GetHandler():AddCounter(0x551,1)
end
function c77239267.ctop(e,tp,eg,ep,ev,re,r,rp)
		e:GetHandler():AddCounter(0x551,1)
end