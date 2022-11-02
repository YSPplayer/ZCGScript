--奥利哈刚 黑暗大法师 （ZCG）
function c77239291.initial_effect(c)
	  --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c77239291.spcon)
	e1:SetOperation(c77239291.spop)
	c:RegisterEffect(e1)
 --destroy
	local e10=Effect.CreateEffect(c)
	e10:SetCategory(CATEGORY_TODECK)
	e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_BATTLE_START)
	e10:SetProperty(EFFECT_FLAG_DELAY)
	e10:SetTarget(c77239291.destg)
	e10:SetOperation(c77239291.desop)
	c:RegisterEffect(e10)
--destory
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTarget(c77239291.dstg)
	e3:SetOperation(c77239291.dsop)
	c:RegisterEffect(e3)
 --win
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_ADJUST)
	e10:SetRange(LOCATION_ONFIELD+LOCATION_HAND)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetCondition(c77239291.wincon)
	e10:SetOperation(c77239291.winop)
	c:RegisterEffect(e10)
 --damage
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(77239291,1))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetCondition(c77239291.dmcon)
	e6:SetTarget(c77239291.dmtg)
	e6:SetOperation(c77239291.dmop)
	c:RegisterEffect(e6)
end
function c77239291.dmcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_BATTLE) and rp==1-tp
end
function c77239291.dmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,e:GetHandler():GetControler(),0,LOCATION_ONFIELD,1,nil) end
end
function c77239291.dmop(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.SelectMatchingCard(e:GetHandler():GetControler(),aux.TRUE,e:GetHandler():GetControler(),0,LOCATION_ONFIELD,1,1,nil)
		if #g>0 then
		Duel.Destroy(g,REASON_EFFECT+REASON_RULE)
	end 
end
function c77239291.winop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_DESTINY_LEO=0x515
	Duel.Win(tp,WIN_REASON_DESTINY_LEO)
end
function c77239291.winfilter(c)
return c:IsSetCard(0xa50) and c:IsRace(RACE_SPELLCASTER)
end
function c77239291.wincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77239291.winfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,4,nil)
end
function c77239291.dstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_HAND,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
end
function c77239291.cfilter(c,e,tp)
	return c:IsSetCard(0xa50) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c77239291.dsop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_HAND,nil)
	local ct=Duel.SendtoGrave(sg,REASON_DISCARD)
	if ct~=0 then
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct2=g:Filter(c77239291.cfilter,nil,e,tp)
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft1>0 and #ct2>0 and Duel.SelectYesNo(tp,aux.Stringid(77239291,0))  then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft1=1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=ct2:Select(tp,ft1,ft1,nil,e,tp)
		if sg:GetCount()>0 then
			local tc=sg:GetFirst()
			while tc do
				Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
				tc=sg:GetNext()
			 end
		   Duel.SpecialSummonComplete()
		end
	end
end
end
function c77239291.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if chk==0 then return tc and tc:IsFaceup() and tc:GetAttack()>=c:GetAttack() end
end
function c77239291.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if tc:IsRelateToBattle() and tc:GetAttack()>=c:GetAttack() then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	end
end
function c77239291.spfilter(c)
	return c:IsSetCard(0xa50) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c77239291.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c77239291.spfilter,tp,LOCATION_GRAVE,0,10,nil)
end
function c77239291.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c77239291.spfilter,tp,LOCATION_GRAVE,0,10,10,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end