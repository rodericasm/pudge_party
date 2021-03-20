require("ai_core")

behaviour_system = {}
random_timers_array = {}
random_timers_iterator = 0

function Spawn(entityKeyValues)
    thisEntity:SetContextThink("ai_think", ai_think, 0.25)
    behaviour_system = ai_core:create_behaviour_system({behaviour_roam})
    --block is needed for strange behaviour in lua random, without it, first number can be predictable.
    math.randomseed(RandomInt(0, 1000))
    math.random()
    --
    for i = 0, 10 do
        random_timers_array[i] = math.random(RandomFloat(0, 2.5))
    end
end

function ai_think() -- For some reason AddThinkToEnt doesn't accept member functions
    return behaviour_system:think()
end

--behaviour roam

behaviour_roam = {}

function behaviour_roam:evaluate()
    return 1
end

function behaviour_roam:begin()
    self.endTime = GameRules:GetGameTime() + random_timers_array[random_timers_iterator]
    self.order = {
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = Vector(0, 0) + RandomVector(900)
    }

    if random_timers_iterator >= table.getn(random_timers_array) - 1 then
        random_timers_iterator = 0
    else
        random_timers_iterator = random_timers_iterator + 1
    end
end

behaviour_roam.continue = behaviour_roam.begin --just reissue the begin on continue
