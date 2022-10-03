data:extend(
        {
            {
                type = "font",
                name = "btc_font",
                from = "default-bold",
                size = 16
            }
        }
)

data.raw["gui-style"].default["sc_btc_button"] = {
    type = "button_style",
    font = "btc_font",
    font_color = { r = 1, g = 0.2, b = 0.3 },
    parent = "button",
    default_graphical_set = {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        corner_size = { 2, 2 },
        position = { 8, 0 }
    },
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,

    maximal_width = 35,
    minimal_width = 35,

    left_click_sound = {
        {
            filename = "__core__/sound/gui-click.ogg",
            volume = 1
        }
    },

}

data.raw["gui-style"].default["btc_label"] = {
    type = "label_style",
    font = "btc_font",
    font_color = { r = 1, g = 0.2, b = 0.3 },
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
}

data:extend({
    {
        type = "custom-input",
        name = "btc-decrease",
        key_sequence = "MINUS"
    },
    {
        type = "custom-input",
        name = "btc-increase",
        key_sequence = "EQUALS"
    },
    {
        type = "custom-input",
        name = "btc-set-normal",
        key_sequence = "CONTROL + SPACE"
    },
    {
        type = "custom-input",
        name = "btc-set-maximum",
        key_sequence = "CONTROL + SHIFT + SPACE"
    },
})