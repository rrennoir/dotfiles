return {
    {
        "williamboman/mason.nvim",
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    -- LSP Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
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
}
