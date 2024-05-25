require('tokyonight').setup({
    on_highlights = function(hl, c)
        local prompt = "#2d3149"

        -- Spelling
        hl.SpellBad = {
            undercurl = true,
            sp = '#7F3A43',
        }

        -- Telescope
        hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }

        -- Lualine
        hl.StatusLineNonText = {
            bg = c.bg_dark,
            fg = c.fg_gutter,
        }

        -- Indent
        hl.IndentBlanklineChar = {
            fg = c.bg_highlight,
        }

        -- Floaterm
        hl.Floaterm = {
            bg = prompt,
        }
        hl.FloatermBorder = {
            bg = prompt,
            fg = prompt,
        }

        -- Copilot
        hl.CopilotSuggestion = {
            fg = c.comment,
        }

        hl.ColorColumn = {
          bg = c.bg_highlight,
        }
    end,
})

vim.cmd('colorscheme tokyonight')
