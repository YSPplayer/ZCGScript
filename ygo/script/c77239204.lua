--奥利哈刚 恶魔化蕾欧丝 （ZCG）
function c77239204.initial_effect(c)
		c:EnableReviveLimit()
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c77239204.spcon)
	e2:SetOperation(c77239204.spop)
	c:RegisterEffect(e2)
  --atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c77239204.value)
	c:RegisterEffect(e5)
	--damage val
	local e4=e2:Clone()
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e4)
	--damage 0
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_CHANGE_DAMAGE)
	e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(1,0)
	e10:SetValue(c77239204.damval)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e11)
		--immune effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetTarget(c77239204.etarget)
	e3:SetValue(c77239204.efilter)
	c:RegisterEffect(e3)
--copy
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c77239204.coccon)
	e6:SetTarget(c77239204.cotg)
	e6:SetOperation(c77239204.coop)
	c:RegisterEffect(e6)
--copyMAX
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(77239204,2))
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCost(c77239204.spcost2)
	e7:SetOperation(c77239204.spop2)
	c:RegisterEffect(e7)

end
function c77239204.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 then return 0 end
	return val
end
function c77239204.cffilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c77239204.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77239204.cffilter,tp,LOCATION_DECK,0,1,nil) end
	local dg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	Duel.ConfirmCards(tp,dg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c77239204.cffilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	card77239204=g:GetFirst()
	Duel.ConfirmCards(1-tp,card77239204)
	Duel.ShuffleDeck(tp)
end
function c77239204.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local code=card77239204:GetOriginalCode()
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD)
end
function c77239204.coccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c77239204.cotg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c77239204.coop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,98710403,0,TYPES_TOKEN_MONSTER,0,2500,4,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,98710403)
	if Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)~=0 then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c77239204.atlimit)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
	token:RegisterEffect(e1)
end
end
function c77239204.atlimit(e,c)
	return c~=e:GetHandler()
end
function c77239204.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xa50)
end
function c77239204.value(e,c)
	return Duel.GetMatchingGroupCount(c77239204.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*500
end
function c77239204.etarget(e,c)
	return c:IsSetCard(0xa50) and c:IsType(TYPE_MONSTER)
end
function c77239204.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c77239204.rfilter(c,tp)
	return c:IsSetCard(0xa50) and (c:IsControler(tp) or c:IsFaceup()) and c:IsType(TYPE_MONSTER)
end
function c77239204.mzfilter(c,tp)
	return c:IsControler(tp) and c:GetSequence()<5
end
function --奥利哈刚 恶魔化蕾欧丝 （ZCG）
function c77239204.initial_effect(c)
		c:EnableReviveLimit()
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c77239204.spcon)
	e2:SetOperation(c77239204.spop)
	c:RegisterEffect(e2)
  --atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c77239204.value)
	c:RegisterEffect(e5)
	--damage val
	local e4=e2:Clone()
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e4)
	--damage 0
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_CHANGE_DAMAGE)
	e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(1,0)
	e10:SetValue(c77239204.damval)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e11)
		--immune effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetTarget(c77239204.etarget)
	e3:SetValue(c77239204.efilter)
	c:RegisterEffect(e3)
--copy
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c77239204.coccon)
	e6:SetTarget(c77239204.cotg)
	e6:SetOperation(c77239204.coop)
	c:RegisterEffect(e6)
--copyMAX
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(77239204,2))
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCost(c77239204.spcost2)
	e7:SetOperation(c77239204.spop2)
	c:RegisterEffect(e7)

end
function c77239204.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 then return 0 end
	return val
end
function c77239204.cffilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c77239204.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77239204.cffilter,tp,LOCATION_DECK,0,1,nil) end
	local dg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	Duel.ConfirmCards(tp,dg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c77239204.cffilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	card77239204=g:GetFirst()
	Duel.ConfirmCards(1-tp,card77239204)
	Duel.ShuffleDeck(tp)
end
function c77239204.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local code=card77239204:GetOriginalCode()
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD)
end
function c77239204.coccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c77239204.cotg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c77239204.coop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,77239205,0,TYPES_TOKEN_MONSTER,0,2500,4,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,77239205)
	if Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)~=0 then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c77239204.atlimit)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
	token:RegisterEffect(e1)
end
end
function c77239204.atlimit(e,c)
	return c~=e:GetHandler()
end
function c77239204.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xa50)
end
function c77239204.value(e,c)
	return Duel.GetMatchingGroupCount(c77239204.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*500
end
function c77239204.etarget(e,c)
	return c:IsSetCard(0xa50) and c:IsType(TYPE_MONSTER)
end
function c77239204.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c77239204.rfilter(c,tp)
	return c:IsSetCard(0xa50) and (c:IsControler(tp) or c:IsFaceup()) and c:IsType(TYPE_MONSTER)
end
function c77239204.mzfilter(c,tp)
	return c:IsControler(tp) and c:GetSequence()<5
end
function c77239204.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetReleaseGroup(tp):Filter(c77239204.rfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	return ft>-3 and rg:GetCount()>2 and (ft>0 or rg:IsExists(c77239204.mzfilter,ct,nil,tp))
end
function c77239204.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetReleaseGroup(tp):Filter(c77239204.rfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=nil
	if ft>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:Select(tp,3,3,nil)
	elseif ft>-2 then
		local ct=-ft+1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c77239204.mzfilter,ct,ct,nil,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g2=rg:Select(tp,3-ct,3-ct,g)
		g:Merge(g2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c77239204.mzfilter,3,3,nil,tp)
	end
	Duel.Release(g,REASON_COST)
end
function c77239204.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetReleaseGroup(tp):Filter(c77239204.rfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	return ft>-3 and rg:GetCount()>2 and (ft>0 or rg:IsExists(c77239204.mzfilter,ct,nil,tp))
end
function c77239204.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetReleaseGroup(tp):Filter(c77239204.rfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=nil
	if ft>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:Select(tp,3,3,nil)
	elseif ft>-2 then
		local ct=-ft+1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c77239204.mzfilter,ct,ct,nil,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g2=rg:Select(tp,3-ct,3-ct,g)
		g:Merge(g2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c77239204.mzfilter,3,3,nil,tp)
	end
	Duel.Release(g,REASON_COST)
end