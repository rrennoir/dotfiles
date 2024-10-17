return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        transparent_background = true,
        custom_highlights = function(colors)
            return {
                LineNr = { fg = colors.teal },
            }
        end
    },
}
