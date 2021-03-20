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
ai_core = {} --This is a fatory system that makes behaviour systems.

function ai_core:create_behaviour_system(behaviour_list)
	local behaviour_system = {}
	behaviour_system.behaviour_list = behaviour_list
	behaviour_system.think_duration = 1
	behaviour_system.reissue_orders = true

	-- default behaviour
	behaviour_system.current_behaviour = {
		endTime = 0,
		order = {OrderType = DOTA_UNIT_ORDER_NONE}
	}

	function behaviour_system:think()
		if GameRules:GetGameTime() >= self.current_behaviour.endTime then
			local new_behaviour = self:choose_next_behaviour()

			if new_behaviour == nil then
				-- Do nothing here... this covers possible problems with ChooseNextBehavior FIX THIS WHY IS THERE A SPACE HERE
				print("nothing here")
			elseif newBehavior == self.current_behaviour then
				self.current_behaviour:continue()
			else
				if self.current_behaviour.close then
					self.current_behaviour:close()
				end
				self.current_behaviour = new_behaviour
				self.current_behaviour:begin()
			end

			if self.current_behaviour.order and self.current_behaviour.order.OrderType ~= DOTA_UNIT_ORDER_NONE then
				-- Keep sending the order repeatedly, in case we forgot >.<
				ExecuteOrderFromTable(self.current_behaviour.order)
				self.previousOrderType = self.current_behaviour.order.OrderType
				self.previousOrderTarget = self.current_behaviour.order.TargetIndex
				self.previousOrderPosition = self.current_behaviour.order.Position
			end
		end

		if self.current_behaviour.Think then
			self.current_behaviour:Think(self.think_duration)
		end

		return self.think_duration
	end

	function behaviour_system:choose_next_behaviour()
		local result = nil
		local best_desire = nil
		for _, behavior in pairs(self.behaviour_list) do
			local this_desire = behavior:evaluate()
			if best_desire == nil or this_desire > best_desire then
				result = behavior
				best_desire = this_desire
			end
		end

		return result
	end

	return behaviour_system
end
