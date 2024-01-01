require("lazy").setup({
    { "catppuccin/nvim",                 name = "catppuccin", priority = 1000 },
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.5',
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" }
        }
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "freddiehaddad/feline.nvim",
    "theprimeagen/harpoon",
    "ranjithshegde/ccls.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- LSP Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        }
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'L3MON4D3/LuaSnip' }
        },
    },
})
