--奥利哈刚之神 （ZCG）
function c77239230.initial_effect(c)
	  c:EnableReviveLimit()
		--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--destroy
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e9:SetCategory(CATEGORY_DAMAGE)
	e9:SetCode(EVENT_BATTLE_DESTROYING)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetCondition(aux.bdocon)
	e9:SetTarget(c77239230.detg)
	e9:SetOperation(c77239230.deop)
	c:RegisterEffect(e9)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c77239230.disop9)
	c:RegisterEffect(e12)
end
function c77239230.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	local dam=tc:GetAttack()*2+2000
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c77239230.deop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

function c77239230.disop9(e,tp,eg,ep,ev,re,r,rp)
	 local tc=re:GetHandler()
	if tc:IsType(TYPE_TRAP+TYPE_SPELL) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and tc:GetControler()~=e:GetHandler():GetControler() then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end