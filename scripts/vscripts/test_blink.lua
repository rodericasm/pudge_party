test_blink = class({})

function test_blink:OnSpellStart()
    local target = self:GetCursorPosition()
	EmitSoundOn( "Hero_Pudge.Rot", self:GetCaster() )
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 1000, 1000, 1000 ) )
    print(target)

    
end