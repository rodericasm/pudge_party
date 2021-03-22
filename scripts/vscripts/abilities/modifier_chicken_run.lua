modifier_chicken_run = class({})
--------------------------------------------------------------------------------

function modifier_chicken_run:OnCreated(kv)
    self.thirst_movespeed = self:GetAbility():GetSpecialValueFor("thirst_movespeed")
    if IsServer() then
        self.nFXIndex =
            ParticleManager:CreateParticle(
            "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self:GetParent()
        )
        ParticleManager:SetParticleControl(self.nFXIndex, 1, Vector(self:GetStackCount(), 0, 0))
        self:AddParticle(self.nFXIndex, false, false, -1, false, false)
    end
    self:SetStackCount(1)
end

--------------------------------------------------------------------------------

function modifier_chicken_run:OnRefresh(kv)
    self.thirst_movespeed = self:GetAbility():GetSpecialValueFor("thirst_movespeed")
    if IsServer() then
        self.nFXIndex =
            ParticleManager:CreateParticle(
            "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self:GetParent()
        )
        ParticleManager:SetParticleControl(self.nFXIndex, 1, Vector(self:GetStackCount(), 0, 0))
        self:AddParticle(self.nFXIndex, false, false, -1, false, false)
    end
    self:SetStackCount(1)
end

--------------------------------------------------------------------------------

function modifier_chicken_run:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MOVESPEED_MAX,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
    }

    return funcs
end

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------

function modifier_chicken_run:GetModifierMoveSpeed_Max()
    return self.thirst_movespeed
end

function modifier_chicken_run:GetModifierMoveSpeed_Limit()
    return self.thirst_movespeed
end

function modifier_chicken_run:GetModifierMoveSpeed_Absolute()
    return self.thirst_movespeed
end
