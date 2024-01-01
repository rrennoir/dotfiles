require("catppuccin").setup({
	transparent_background = true,
    custom_highlights = function (colors)
        return {
            LineNr = { fg = colors.teal },
        }
    end
})

vim.cmd.colorscheme "catppuccin-macchiato"
