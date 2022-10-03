require "util"

script.on_configuration_changed(function(_)
    createHud()
end)

script.on_event(defines.events, function(event)
    if event.name == defines.events.on_player_joined_game then
        createHud()
    end

    -- on_gui_click
    if event.name == defines.events.on_gui_click then
        if event.element.name == "btc-decrease" then
            setSpeed(game.speed - 1)
        end
        if event.element.name == "btc-increase" then
            setSpeed(game.speed + 1)
        end
        if event.element.name == "btc-set-normal" then
            setSpeed(1.0)
        end
        if event.element.name == "btc-set-maximum" then
            setSpeed(10.0)
        end
    end
end)

function createHud()
    for playerIndex, player in pairs(game.players) do
        local gui = player.gui.top

        if gui["btc-set-normal"] == nil then
            gui.add { name = "btc-set-normal", type = "button", caption = "x1", style = "sc_btc_button", tooltip = { "better-speed-control.btc-set-normal-tooltip" } }
        end

        if gui["btc-decrease"] == nil then
            gui.add { name = "btc-decrease", type = "button", caption = "-x1", style = "sc_btc_button", tooltip = { "better-speed-control.btc-decrease-tooltip" } }
        end

        if gui["btc--display"] == nil then
            gui.add { name = "btc--display", type = "label", caption = getSpeedString(), style = "btc_label", tooltip = { "better-speed-control.btc--display-tooltip" } }
        end

        if gui["btc-increase"] == nil then
            gui.add { name = "btc-increase", type = "button", caption = "+x1", style = "sc_btc_button", tooltip = { "better-speed-control.btc-increase-tooltip" } }
        end

        if gui["btc-set-maximum"] == nil then
            gui.add { name = "btc-set-maximum", type = "button", caption = "x10", style = "sc_btc_button", tooltip = { "better-speed-control.btc-set-maximum-tooltip" } }
        end
    end
end

function setSpeed(speed)
    game.speed = math.clamp(speed, 0.5, 10)
    for playerIndex, player in pairs(game.players) do
        if player.gui.top["btc--display"] then
            player.gui.top["btc--display"].caption = getSpeedString()
        end
    end
end

function math.clamp(val, lower, upper)
    if lower > upper then
        lower, upper = upper, lower
    end

    return math.max(lower, math.min(upper, val))
end

function getSpeedString()
    -- actually only one value is fractional - it is 0.5
    if game.speed < 1 then
        return string.format("x%.1f", game.speed)
    else
        return string.format("x%d", game.speed)
    end
end

script.on_event("btc-decrease", function(event)
    return setSpeed(game.speed - 1)
end)
script.on_event("btc-increase", function(event)
    return setSpeed(game.speed + 1)
end)
script.on_event("btc-set-normal", function(event)
    return setSpeed(1.0)
end)
script.on_event("btc-set-maximum", function(event)
    return setSpeed(10.0)
end)