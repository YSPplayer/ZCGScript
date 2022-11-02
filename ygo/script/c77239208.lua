--奥利哈刚 拉菲鲁 （ZCG）
function c77239208.initial_effect(c)
			  --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK)
	e1:SetCondition(c77239208.spcon3)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(77239208,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCondition(c77239208.spcon3)
	e2:SetTarget(c77239208.sptg3)
	e2:SetOperation(c77239208.spop3)
	c:RegisterEffect(e2)
--SpecialSummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(77239208,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c77239208.target)
	e4:SetOperation(c77239208.activate)
	c:RegisterEffect(e4)
end
function c77239208.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_HAND,1,nil)
		and Duel.IsPlayerCanSpecialSummon(tp) end
end
function c77239208.activate(e,tp,eg,ep,ev,re,r,rp)
	getmetatable(e:GetHandler()).announce_filter={TYPE_MONSTER,OPCODE_ISTYPE,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT,OPCODE_AND}
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
	local sg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local g=sg:Filter(Card.IsCode,nil,ac) 
	Duel.ConfirmCards(tp,sg)
	if #g<=0 then Duel.ShuffleHand(1-tp) end
	if #g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=#g and g:GetFirst():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp) then
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	while tc do
	local e1=Effect.CreateEffect(c)
		  e1:SetType(EFFECT_TYPE_SINGLE)
		  e1:SetCode(EFFECT_ADD_SETCODE)
		  e1:SetValue(0xa50)
		  e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		  c:RegisterEffect(e1)
		  tc=g:GetNext()
end
	Duel.ShuffleHand(1-tp)
end
end
function c77239208.spcon3(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0,nil)==0
end
function c77239208.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c77239208.spop3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end