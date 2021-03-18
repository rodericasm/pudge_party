--[[
These are the valid orders, in case you want to use them (easier here than to find them in the C code):

DOTA_UNIT_ORDER_NONE
DOTA_UNIT_ORDER_MOVE_TO_POSITION 
DOTA_UNIT_ORDER_MOVE_TO_TARGET 
DOTA_UNIT_ORDER_ATTACK_MOVE
DOTA_UNIT_ORDER_ATTACK_TARGET
DOTA_UNIT_ORDER_CAST_POSITION
DOTA_UNIT_ORDER_CAST_TARGET
DOTA_UNIT_ORDER_CAST_TARGET_TREE
DOTA_UNIT_ORDER_CAST_NO_TARGET
DOTA_UNIT_ORDER_CAST_TOGGLE
DOTA_UNIT_ORDER_HOLD_POSITION
DOTA_UNIT_ORDER_TRAIN_ABILITY
DOTA_UNIT_ORDER_DROP_ITEM
DOTA_UNIT_ORDER_GIVE_ITEM
DOTA_UNIT_ORDER_PICKUP_ITEM
DOTA_UNIT_ORDER_PICKUP_RUNE
DOTA_UNIT_ORDER_PURCHASE_ITEM
DOTA_UNIT_ORDER_SELL_ITEM
DOTA_UNIT_ORDER_DISASSEMBLE_ITEM
DOTA_UNIT_ORDER_MOVE_ITEM
DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO
DOTA_UNIT_ORDER_STOP
DOTA_UNIT_ORDER_TAUNT
DOTA_UNIT_ORDER_BUYBACK
DOTA_UNIT_ORDER_GLYPH
DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH
DOTA_UNIT_ORDER_CAST_RUNE
]]

AICore = {} --This is a fatory system that makes behaviour systems.

function AICore:create_behaviour_system ( behaviour_list )
    local behaviour_system = {}
    behaviour_system.think_duration = 1
    behaviour_system.behaviour_list = behaviour_list
    behaviour_system.reissue_orders = true
    
    -- default behaviour
    BehaviorSystem.current_behaviour =
	{
		endTime = 0,
		order = { OrderType = DOTA_UNIT_ORDER_NONE }
	}

    function behaviour_system:Think()
        if GameRules:GetGameTime() >= self.current_behaviour.endTime then
			local new_behaviour = self:ChooseNextBehavior()
			if new_behaviour == nil then 
				-- Do nothing here... this covers possible problems with ChooseNextBehavior
			elseif newBehavior == self.current_behaviour then
				self.current_behaviour:Continue()
			else
				if self.current_behaviour.End then self.current_behaviour:End() end
				self.current_behaviour = new_behaviour
				self.current_behaviour:Begin()
			end

            --test and see if you need to use logic to repeat orders. maybe you can just refresh them every cycle
    end

    function choose_next_behaviour()
        local result = nil
		local best_desire = nil
		for _,behavior in pairs( self.possibleBehaviors ) do
			local this_desire = behavior:Evaluate()
			if best_desire == nil or this_desire > best_desire then
				result = behavior
				best_desire = this_desire
			end
		end

		return result
    end

    return state_machine
end

