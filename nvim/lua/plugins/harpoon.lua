return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<C-&>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-é>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", '<C-">', function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-'>", function() harpoon:list():select(4) end)
        return {
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            }
        }
    end
}
