require "util"

function ui()
    for playerIndex, player in pairs(game.players) do
        if player.gui.top["btc-set-normal"] == nil then
            player.gui.top.add { name = "btc-set-normal", type = "button", caption = "x1", style = "sc_btc_button" }
        end

        if player.gui.top["btc-decrease"] == nil then
            player.gui.top.add { name = "btc-decrease", type = "button", caption = "-x1", style = "sc_btc_button" }
        end

        if player.gui.top["btc--display"] == nil then
            player.gui.top.add { name = "btc--display", type = "label", caption = "Speed " .. tostring(format_num(game.speed, 0, "x", "")), style = "btc_label" }
        end

        if player.gui.top["btc-increase"] == nil then
            player.gui.top.add { name = "btc-increase", type = "button", caption = "+x1", style = "sc_btc_button" }
        end

        if player.gui.top["btc-set-maximum"] == nil then
            player.gui.top.add { name = "btc-set-maximum", type = "button", caption = "x10", style = "sc_btc_button" }
        end
    end
end

script.on_configuration_changed(function(_)
    ui()
end)

script.on_event(defines.events, function(event)
    if event.name == defines.events.on_player_joined_game then
        ui()
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

function setSpeed(speed)
    game.speed = math.clamp(speed, 0.5, 10)

    for playerIndex, player in pairs(game.players) do
        if player.gui.top["btc--display"] then
            player.gui.top["btc--display"].caption = "Speed " .. tostring(format_num(game.speed, 0, "x", ""))
        end
    end
end

function format_num(amount, decimal, prefix, neg_prefix)
    local str_amount, formatted, famount, remain

    decimal = decimal or 2
    neg_prefix = neg_prefix or "-"

    famount = math.abs(round(amount, decimal))
    famount = math.floor(famount)

    remain = round(math.abs(amount) - famount, decimal)

    formatted = comma_value(famount)

    if (decimal > 0) then
        remain = string.sub(tostring(remain), 3)
        formatted = formatted .. "." .. remain ..
                string.rep("0", decimal - string.len(remain))
    end

    formatted = (prefix or "") .. formatted

    if (amount < 0) then
        if (neg_prefix == "()") then
            formatted = "(" .. formatted .. ")"
        else
            formatted = neg_prefix .. formatted
        end
    end

    return formatted
end

function round(val, decimal)
    if (decimal) then
        return math.floor((val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
    else
        return math.floor(val + 0.5)
    end
end

function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

function math.clamp(val, lower, upper)
    if lower > upper then
        lower, upper = upper, lower
    end

    return math.max(lower, math.min(upper, val))
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