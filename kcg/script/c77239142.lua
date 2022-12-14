--究极青眼日龙(ZCG)
function c77239142.initial_effect(c)
    c:EnableReviveLimit()
    --remove
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(77239142,0))
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    --e1:SetCondition(c77239142.remcon)
    e1:SetTarget(c77239142.remtg)
    e1:SetOperation(c77239142.remop)
    c:RegisterEffect(e1)
end
function c77239142.remcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_RITUAL
end
function c77239142.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,0x1e,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0x1e)
end
function c77239142.remop(e,tp,eg,ep,ev,re,r,rp)
    local g1=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,nil)
    local g2=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,nil)
    local g3=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
    local sg=Group.CreateGroup()
    if g1:GetCount()>0 and ((g2:GetCount()==0 and g3:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(77239142,1))) then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
        local sg1=g1:Select(tp,1,1,nil)
        Duel.HintSelection(sg1)
        sg:Merge(sg1)
    end
    if g2:GetCount()>0 and ((sg:GetCount()==0 and g3:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(77239142,2))) then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
        local sg2=g2:Select(tp,1,1,nil)
        Duel.HintSelection(sg2)
        sg:Merge(sg2)
    end
    if g3:GetCount()>0 and (sg:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(77239142,3))) then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
        local sg3=g3:RandomSelect(tp,1)
        sg:Merge(sg3)
    end
    Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end
