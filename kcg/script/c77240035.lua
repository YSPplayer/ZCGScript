--奥西里斯之魔兽法师
function c77240035.initial_effect(c)

    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EVENT_DRAW)
    e1:SetCondition(c77240035.con)
    e1:SetOperation(c77240035.op)
    c:RegisterEffect(e1)

    --抗性
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetValue(c77240035.efilter11)
	c:RegisterEffect(e11)
	--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_MZONE)
	e12:SetOperation(c77240035.disop12)
	c:RegisterEffect(e12)
	--disable
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD)
	e13:SetCode(EFFECT_DISABLE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e13:SetTarget(c77240035.distg12)
	c:RegisterEffect(e13)
	--self destroy
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_FIELD)
	e14:SetCode(EFFECT_SELF_DESTROY)
	e14:SetRange(LOCATION_MZONE)
	e14:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e14:SetTarget(c77240035.distg12)
	c:RegisterEffect(e14)
end
function c77240035.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp --and Duel.GetCurrentPhase()==PHASE_DRAW
end
function c77240035.op(e,tp,eg,ep,ev,re,r,rp)
    if ep~=e:GetOwnerPlayer() then return end
    local hg=eg:Filter(Card.IsLocation,nil,LOCATION_HAND)
    if hg:GetCount()==0 then return end
    Duel.ConfirmCards(1-tp,hg)
    local dg=hg:Filter(Card.IsType,nil,TYPE_MONSTER)
	if Duel.SelectYesNo(tp,aux.Stringid(22567609,1)) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
        Duel.SpecialSummon(dg,0,tp,tp,true,true,POS_FACEUP)
	end	
    Duel.ShuffleHand(tp)
end

function c77240035.efilter11(e,te)
	return te:GetHandler():IsSetCard(0xa60)
end
function c77240035.disop12(e,tp,eg,ep,ev,re,r,rp)
	if (re:GetHandler():IsSetCard(0xa50) or re:GetHandler():IsSetCard(0xa70)) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c77240035.distg12(e,c)
	return c:GetCardTargetCount()>0 and (re:GetHandler():IsSetCard(0xa50) or re:GetHandler():IsSetCard(0xa70))
		and c:GetCardTarget():IsContains(e:GetHandler())
end