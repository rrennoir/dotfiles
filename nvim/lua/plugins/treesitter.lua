return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local treeshitter_config = require("nvim-treesitter.configs")
        treeshitter_config.setup( {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
