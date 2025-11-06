vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "strict"
            }
        }
    }
})
