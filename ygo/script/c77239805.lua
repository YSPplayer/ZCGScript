--装甲 古代兵器 （ZCG）
function c77239805.initial_effect(c)
		--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
--negate
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e0:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e0:SetCode(EVENT_CHAINING)
	e0:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCondition(c77239805.negcon)
	e0:SetTarget(c77239805.negtg)
	e0:SetOperation(c77239805.negop)
	c:RegisterEffect(e0)
	--discard
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77239805,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c77239805.cost)
	e2:SetTarget(c77239805.target)
	e2:SetOperation(c77239805.operation)
	c:RegisterEffect(e2)
end
function c77239805.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(c) then return false end
	return rp==1-tp
end
function c77239805.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c77239805.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
function c77239805.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c77239805.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=math.floor(Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)/2)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	local ct2=g:Filter(Card.IsAbleToRemove,nil)
	if chk==0 then return ct>0 and #ct2>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,ct,1-tp,LOCATION_DECK)
end
function c77239805.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.floor(Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)/2)
	local sg=Duel.GetDecktopGroup(1-tp,ct)
	if #sg<=0 then return end
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end







