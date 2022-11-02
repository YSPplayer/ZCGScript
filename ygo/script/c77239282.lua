--奥利哈刚的圣光 （ZCG）
function c77239282.initial_effect(c)
	 --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c77239282.activate)
	c:RegisterEffect(e1)
end
function c77239282.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local opt=Duel.SelectOption(tp,aux.Stringid(77239282,1),aux.Stringid(77239282,2),aux.Stringid(77239282,3))
	if opt==0 then
	--inactivatable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_INACTIVATE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetValue(c77239282.effectfilter)
	c:RegisterEffect(e4)
   elseif opt==1 then
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e4)
	  elseif opt==1 then
	 --act limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	e2:SetValue(c77239282.aclimit)
	c:RegisterEffect(e2)
--cannot set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_MSET)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(EFFECT_CANNOT_SSET)
	e4:SetTargetRange(0,1)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetTarget(c77239282.aclimit2)
end
end
function c77239282.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) 
end
function c77239282.aclimit2(e,re,tp)
	return re:GetHandler():GetType(TYPE_FIELD) 
end
function c77239282.effectfilter(e,ct)
	local te,tp,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION)
	return te:GetHandler():IsSetCard(0xa50)
end