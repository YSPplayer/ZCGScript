--植物的愤怒 绿色超融合
function c77239641.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetHintTiming(0,0x1e0)
    e1:SetCost(c77239641.cost)
    e1:SetTarget(c77239641.target)
    e1:SetOperation(c77239641.activate)
    c:RegisterEffect(e1)
end
function c77239641.filter0(c)
    return c:IsFaceup() and c:IsCanBeFusionMaterial()
end
function c77239641.filter1(c,e)
    return c:IsFaceup() and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c77239641.filter2(c,e,tp,m,f,chkf)
    return c:IsType(TYPE_FUSION) and (not f or f(c))
        and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c77239641.filter3(c,e)
    return c:IsOnField() and not c:IsImmuneToEffect(e)
end
function c77239641.cfilter(c)
    return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c77239641.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
    hg:RemoveCard(e:GetHandler())
    if chk==0 then return hg:GetCount()>0 and hg:FilterCount(c77239641.cfilter,nil)==hg:GetCount() end
    Duel.SendtoGrave(hg,REASON_COST+REASON_DISCARD)
end
function c77239641.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
        local mg1=Duel.GetMatchingGroup(c77239641.filter0,tp,LOCATION_MZONE+LOCATION_DECK,0,nil)
        local mg2=Duel.GetMatchingGroup(c77239641.filter0,tp,0,LOCATION_MZONE+LOCATION_DECK,nil)
        mg1:Merge(mg2)
        local res=Duel.IsExistingMatchingCard(c77239641.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
        if not res then
            local ce=Duel.GetChainMaterial(tp)
            if ce~=nil then
                local fgroup=ce:GetTarget()
                local mg3=fgroup(ce,e,tp)
                local mf=ce:GetValue()
                res=Duel.IsExistingMatchingCard(c77239641.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,chkf)
            end
        end
        return res
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
    if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
        Duel.SetChainLimit(aux.FALSE)
    end
end
function c77239641.activate(e,tp,eg,ep,ev,re,r,rp)
    local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
    local mg1=Duel.GetMatchingGroup(c77239641.filter1,tp,LOCATION_MZONE+LOCATION_DECK,0,nil,e)
    local mg2=Duel.GetMatchingGroup(c77239641.filter1,tp,0,LOCATION_MZONE+LOCATION_DECK,nil,e)
    mg1:Merge(mg2)
    local sg1=Duel.GetMatchingGroup(c77239641.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
    local mg3=nil
    local sg2=nil
    local ce=Duel.GetChainMaterial(tp)
    if ce~=nil then
        local fgroup=ce:GetTarget()
        mg3=fgroup(ce,e,tp)
        local mf=ce:GetValue()
        sg2=Duel.GetMatchingGroup(c77239641.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,mf,chkf)
    end
    if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
        local sg=sg1:Clone()
        if sg2 then sg:Merge(sg2) end
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local tg=sg:Select(tp,1,1,nil)
        local tc=tg:GetFirst()
        if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
            local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
            tc:SetMaterial(mat1)
            Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
            Duel.BreakEffect()
            Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
        else
            local mat2=Duel.SelectFusionMaterial(tp,tc,mg3,nil,chkf)
            local fop=ce:GetOperation()
            fop(ce,e,tp,tc,mat2)
        end
        tc:CompleteProcedure()
    end
end
