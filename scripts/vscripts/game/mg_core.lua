--require the all the mini games
require("game/mg_hungry_pudge")

mg_core = {}

mg_core.minigame_list = {mg_hungry_pudge}
mg_core.default_think_duration = 1
mg_core.minigame_iterator = 0
mg_core.minigame_list_size = table.getn(mg_core.minigame_list)
mg_core.games_finished = false

function mg_core:think()
    if mg_core.minigame_iterator < mg_core.minigame_list_size then
        local current_iterator = mg_core.minigame_iterator

        if self.current_minigame.is_game_over and self.current_minigame:is_game_over() then
            mg_core.minigame_iterator = mg_core.minigame_iterator + 1
            self.current_minigame = mg_core.minigame_list[minigame_iterator]
        else
            mg_core.games_finished = true
        end

        if current_iterator ~= mg_core.minigame_iterator then
            self.current_minigame.begin()
        end
    end
end

function mg_core:get_finished_state()
    return mg_core.games_finished
end
