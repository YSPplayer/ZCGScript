--奥利哈刚的诅咒 （ZCG）
function c77239279.initial_effect(c)
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetRange(LOCATION_DECK)
	e0:SetCondition(c77239279.mocon)
	e0:SetOperation(c77239279.moop)
	c:RegisterEffect(e0)
--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_DECK)
	e1:SetCondition(c77239279.mocon2)
	e1:SetOperation(c77239279.moop2)
	c:RegisterEffect(e1)
end
function c77239279.mocon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c77239279.moop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE,0)>0 then
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.BreakEffect()
	if  not Duel.IsExistingMatchingCard(Card.IsAbleToHand,e:GetHandler():GetControler(),0,LOCATION_DECK,5,nil) then return Duel.SendtoGrave(e:GetHandler(),REASON_RULE) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,e:GetHandler():GetControler(),0,LOCATION_DECK,nil)
	Duel.ConfirmCards(tp,g)
   local hg=Duel.SelectMatchingCard(e:GetHandler():GetControler(),Card.IsAbleToHand,e:GetHandler():GetControler(),0,LOCATION_DECK,5,5,nil)
	if hg:GetCount()>0 then
		Duel.SendtoHand(hg,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,hg)
		Duel.SendtoGrave(e:GetHandler(),REASON_RULE)
		end
		Duel.SendtoGrave(e:GetHandler(),REASON_RULE)
	end
end
function c77239279.mocon2(e,tp,eg,ep,ev,re,r,rp)
	return 1-tp==Duel.GetTurnPlayer()
end
function c77239279.moop2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE,0)>0 then
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.BreakEffect()
	if  not Duel.IsExistingMatchingCard(Card.IsAbleToRemove,e:GetHandler():GetControler(),0,LOCATION_DECK,10,nil) then return Duel.SendtoGrave(e:GetHandler(),REASON_RULE) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,e:GetHandler():GetControler(),0,LOCATION_DECK,nil)
	Duel.ConfirmCards(tp,g)
   local hg=Duel.SelectMatchingCard(e:GetHandler():GetControler(),Card.IsAbleToRemove,e:GetHandler():GetControler(),0,LOCATION_DECK,10,10,nil)
	if hg:GetCount()>0 then
		Duel.Remove(hg,POS_FACEUP,REASON_EFFECT)
		Duel.SendtoGrave(e:GetHandler(),REASON_RULE)
		end
	  Duel.SendtoGrave(e:GetHandler(),REASON_RULE)
	end
end

