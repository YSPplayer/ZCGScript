--奥利哈刚 圣犬(ZCG)
function c77239224.initial_effect(c)
    --flip
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_CONTROL+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetTarget(c77239224.target)
    e1:SetOperation(c77239224.operation)
    c:RegisterEffect(e1)
end 

function c77239224.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
    local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c77239224.operation(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
        if tc and tc:IsRelateToEffect(e) then
        if Duel.GetControl(tc,tp) then
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_ATTACK)
            e1:SetReset(RESET_EVENT+0x1ff0000)
            e1:SetValue(500)
            tc:RegisterEffect(e1)
            local e2=Effect.CreateEffect(e:GetHandler())
            e2:SetType(EFFECT_TYPE_SINGLE)
            e2:SetCode(EFFECT_UPDATE_DEFENSE)
            e2:SetReset(RESET_EVENT+0x1ff0000)
            e2:SetValue(500)
            tc:RegisterEffect(e2)
        elseif not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
            Duel.Destroy(tc,REASON_EFFECT)
        end
    end
end