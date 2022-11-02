--装甲 能源供给 （ZCG）
function c77239835.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
		--Effect Draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(3)
	e2:SetCondition(c77239835.drcon)
	c:RegisterEffect(e2)
end
function c77239835.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa110)
end
function c77239835.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77239835.cfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end