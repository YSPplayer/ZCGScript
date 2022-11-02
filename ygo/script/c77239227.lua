--奥利哈刚 九头狂蛇 （ZCG）
function c77239227.initial_effect(c)
	--to hand  
	local e3=Effect.CreateEffect(c)  
	e3:SetDescription(aux.Stringid(77239227,0))   
	e3:SetType(EFFECT_TYPE_IGNITION)  
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c77239227.spcon)
	e3:SetTarget(c77239227.tftg)  
	e3:SetOperation(c77239227.tfop)  
	c:RegisterEffect(e3) 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77239227,1))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c77239227.tg)
	e1:SetOperation(c77239227.op)
	c:RegisterEffect(e1)
end
function c77239227.filter(c)
	return c:IsSetCard(0xa50) and c:IsLevelBelow(5) and c:IsAbleToHand()
end
function c77239227.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77239227.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c77239227.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c77239227.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end

function c77239227.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)~=0
end
function c77239227.tftg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0  
	end
end
function c77239227.tfop(e,tp,eg,ep,ev,re,r,rp)  
	if  Duel.GetLocationCount(tp,LOCATION_MZONE)>0  then
	 Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
	end
end