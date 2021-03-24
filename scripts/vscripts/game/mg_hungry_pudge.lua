mg_hungry_pudge = {}
mg_hungry_pudge.is_game_over = false
mg_hungry_pudge.is_game_started = false

function mg_hungry_pudge:bootstrap()
    print(mg_hungry_pudge.is_game_over)
    GameRules:GetGameModeEntity():SetThink("hungry_pudge_think", self, "hungry_pudge_think")
end

function hungry_pudge_think()
    print("hungry pudge thinmking")
    return 1
end

function mg_hungry_pudge:game_over_check()
    return mg_hungry_pudge.is_game_over
end
