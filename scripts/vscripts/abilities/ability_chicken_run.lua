ability_chicken_run = class({})
LinkLuaModifier("modifier_chicken_run", "abilities/modifier_chicken_run", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

function ability_chicken_run:GetIntrinsicModifierName()
    return "modifier_chicken_run"
end
