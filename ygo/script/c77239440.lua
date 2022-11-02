--六芒星源 （ZCG）
function c77239440.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	 --Effect Draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c77239440.drcon)
	e2:SetValue(2)
	c:RegisterEffect(e2)
--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c77239440.demcon)
	e3:SetTarget(c77239440.detg)
	e3:SetOperation(c77239440.deop)
	c:RegisterEffect(e3)
end
function c77239440.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa70)
end
function c77239440.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77239440.cfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c77239440.demcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c77239440.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c77239440.deop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0,nil)
	if g:GetCount()~=0 then
	if Duel.SelectYesNo(tp,aux.Stringid(77239440,1))  then 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
	else 
	 Duel.Destroy(e:GetHandler(),REASON_COST)
end
elseif g:GetCount()==0 then
	Duel.Destroy(e:GetHandler(),REASON_COST)
end
end