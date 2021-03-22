--require the all the mini games
require("game/mg_hungry_pudge")

--This is a container for mini games.
game_core = {}

function game_core:create_minigame_system(minigame_list, think_duration)
    local minigame_system = {}
    minigame_system.minigame_list = behaviour_list
    minigame_system.default_think_duration = think_duration

    function game_core:think()
        if
    end

    return minigame_system
end
