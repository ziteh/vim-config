return {
    { -- Main theme
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({ style = "dark" })
        end,
    },
    { "AlexvZyl/nordic.nvim" },
    { "EdenEast/nightfox.nvim" }, -- nordfox
}
