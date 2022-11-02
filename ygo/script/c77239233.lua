--奥利哈刚 翼神龙 （ZCG）
function c77239233.initial_effect(c)
	  --summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77239233,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c77239233.ttcon)
	e1:SetOperation(c77239233.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c77239233.setcon)
	c:RegisterEffect(e2)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(77239233,1))
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SPSUMMON_PROC)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetRange(LOCATION_HAND)
	e5:SetCondition(c77239233.spcon)
	e5:SetOperation(c77239233.spop)
	c:RegisterEffect(e5)
   --summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	c:RegisterEffect(e4)	
   --atk up
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c77239233.atkval)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e7)
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(77239233,2))
	e10:SetCategory(CATEGORY_ATKCHANGE)
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCost(c77239233.descost)
	e10:SetOperation(c77239233.descon)
	c:RegisterEffect(e10)  
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(77239233,3))
	e8:SetCategory(CATEGORY_REMOVE)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCost(c77239233.descost2)
	e8:SetTarget(c77239233.tgtg)
	e8:SetOperation(c77239233.tgop)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(77239233,4))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_MZONE)
	e9:SetOperation(c77239233.efcon)
	c:RegisterEffect(e9)  
	--immune spell
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(c77239233.efilter)
	c:RegisterEffect(e11)
end
function c77239233.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c77239233.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,e:GetHandler():GetControler(),0,LOCATION_ONFIELD,2,nil) end
end
function c77239233.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(e:GetHandler():GetControler(),Card.IsAbleToRemove,e:GetHandler():GetControler(),0,LOCATION_ONFIELD,2,2,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c77239233.desfilter(c)
return c:IsReleasable()
end
function c77239233.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(1-tp)>1 end
	local lp=Duel.GetLP(1-tp)
	local number=lp-1
	Duel.PayLPCost(1-tp,lp-1)
	local g=Duel.GetMatchingGroup(c77239233.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.Release(g,REASON_COST)
	local g2=Duel.GetOperatedGroup()
	local atk=g2:GetSum(Card.GetAttack)+number
	local des=g2:GetSum(Card.GetDefense)+number
	e:SetLabel(atk,des)
end
function c77239233.descon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	local atk,des=e:GetLabel()
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(atk)
	e6:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_UPDATE_DEFENSE)
	e7:SetValue(des)
	c:RegisterEffect(e7)
end
function c77239233.efcon(e,tp,eg,ep,ev,re,r,rp)
   local c=e:GetHandler()
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(1)
	e5:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e5)
end
function c77239233.atkfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c77239233.atkval(e,c)
	local g=Duel.GetMatchingGroup(c77239233.atkfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	local atk=g:GetSum(Card.GetAttack)
	return atk
end
function c77239233.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c77239233.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c77239233.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c77239233.ttcon(e,c,minc)
	if c==nil then return true end
	return minc<=3 and Duel.CheckTribute(c,3)
end
function c77239233.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c77239233.setcon(e,c,minc)
	if not c then return true end
	return false
end