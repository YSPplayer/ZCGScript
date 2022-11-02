--奥利哈刚之神怒 （ZCG）
function c77239254.initial_effect(c)
		--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCondition(c77239254.condition)
	c:RegisterEffect(e0)
		--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77239254,0))
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c77239254.cost)
	e2:SetTarget(c77239254.target)
	e2:SetOperation(c77239254.operation)
	c:RegisterEffect(e2)
end
function c77239254.cfilter(c)
	return c:IsFaceup() and c:IsCode(77239230)
end
function c77239254.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77239254.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c77239254.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
end
function c77239254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	 local ct=math.floor(Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)/2)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,e:GetHandler():GetControler(),0,LOCATION_DECK,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDE,nil,0,1-tp,ct)
end
function c77239254.operation(e,tp,eg,ep,ev,re,r,rp)
local ct=math.floor(Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)/2)
	Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
end