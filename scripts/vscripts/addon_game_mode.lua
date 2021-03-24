require("game_setup")
require("game/mg_core")

--require the all the mini games
require("game/mg_hungry_pudge")

if pudge_party == nil then
	pudge_party = class({})
end

function Precache(context)
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = pudge_party()
	GameRules.AddonTemplate:InitGameMode()
end

function pudge_party:mg_core_bootstrap()
	self.minigame_list = {mg_hungry_pudge}
	self.default_think_duration = 1
	self.minigame_iterator = 1
	self.minigame_list_size = table.getn(self.minigame_list)
	self.current_minigame = self.minigame_list[1]
	GameRules:GetGameModeEntity():SetThink("mg_core_think", self, "mg_core_think", 0)
end

function pudge_party:mg_core_think()
	if self.minigame_iterator <= self.minigame_list_size then
		if self.current_minigame.game_over_check and self.current_minigame:game_over_check() then
			self.minigame_iterator = self.minigame_iterator + 1
			self.current_minigame = self.minigame_list[minigame_iterator]
		-- ADD CLEAN UP FOR THE GAME HERE mg_core.minigame.close() etc.
		end

		if self.current_minigame.bootstrap and self.is_game_started ~= true then
			self.current_minigame.bootstrap()
		end
	else
		self.games_finished = true
		return nil -- see if this cancels the think
	end
	return self.default_think_duration
end

function pudge_party:InitGameMode()
	GameRules:GetGameModeEntity():SetThink("OnThink", self, "GlobalThink", 2)
	self:mg_core_bootstrap()
	GameSetup.init()
	ListenToGameEvent("entity_killed", pudge_party.on_unit_killed, self)
	print(PlayerResource:GetTeam(0))
	CreateUnitByName("npc_chicken_hungry_pudge", Vector(-117, -18, 0), true, nil, nil, DOTA_TEAM_BADGUYS)
	CreateUnitByName("npc_chicken_hungry_pudge", Vector(-117, -18, 0), true, nil, nil, DOTA_TEAM_BADGUYS)
	CreateUnitByName("npc_chicken_hungry_pudge", Vector(-117, -18, 0), true, nil, nil, DOTA_TEAM_BADGUYS)
	CreateUnitByName("npc_chicken_hungry_pudge", Vector(-117, -18, 0), true, nil, nil, DOTA_TEAM_BADGUYS)
	CreateUnitByName("npc_chicken_hungry_pudge", Vector(-117, -18, 0), true, nil, nil, DOTA_TEAM_BADGUYS)
end

function pudge_party:on_unit_killed(event)
	print(event)
end

-- Evaluate the state of the game
function pudge_party:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end
