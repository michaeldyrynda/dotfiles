local M = {}

function M.palette()
    local ok, colors = pcall(function()
        return require("twtheme").palette()
    end)

    if ok then
        return colors
    end

    local catppuccin = require("catppuccin.palettes").get_palette("mocha")
    return {
        fg = catppuccin.text,
        fg_alt = catppuccin.subtext0,
        fg_muted = catppuccin.overlay0,
        fg_subtle = catppuccin.surface2,
        fg_invert = catppuccin.base,
        bg = catppuccin.base,
        bg_alt = catppuccin.mantle,
        bg_panel = catppuccin.mantle,
        bg_statusline = catppuccin.mantle,
        bg_float = catppuccin.mantle,
        bg_line = catppuccin.surface0,
        border = catppuccin.surface1,
        syntax = {
            ["function"] = catppuccin.teal,
            ["string"] = catppuccin.sky,
            ["type"] = catppuccin.mauve,
            ["keyword"] = catppuccin.lavender,
            ["operator"] = catppuccin.overlay1,
            constant = catppuccin.pink,
            variable = catppuccin.text,
        },
        diag = {
            error = catppuccin.red,
            warning = catppuccin.yellow,
            info = catppuccin.blue,
            hint = catppuccin.mauve,
        },
        raw = {},
    }
end

return M
