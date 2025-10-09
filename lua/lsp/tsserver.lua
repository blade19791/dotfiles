vim.lsp.config("tsserver", {
    settings = {
        javascript = {
            format = {
                semicolons = "insert"
            }
        },
        typescript = {
            format = {
                semicolons = "insert"
            }
        }
    }
})
