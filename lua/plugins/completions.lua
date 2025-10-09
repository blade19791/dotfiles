return { -- nvim-cmp and dependencies
{
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
                    "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"},
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- Load friendly-snippets VSCode collection
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Load all custom snippets immediately
        require("luasnip.loaders.from_lua").load({
            paths = vim.fn.stdpath("config") .. "/snippets"
        })

        -- Make JS + React snippets available in related filetypes
        luasnip.filetype_extend("javascriptreact", {"javascript", "react"})
        luasnip.filetype_extend("typescript", {"javascript"})
        luasnip.filetype_extend("typescriptreact", {"javascript", "react"})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true
                }),

                -- VS Code–like Tab behavior
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if entry then
                            cmp.confirm({
                                select = true
                            })
                        else
                            cmp.select_next_item()
                        end
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {"i", "s"}),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            }),

            sources = cmp.config.sources({{
                name = "luasnip"
            }, {
                name = "nvim_lsp"
            }}, {{
                name = "buffer"
            }, {
                name = "path"
            }}),

            -- Custom formatting with icons
            formatting = {
                format = function(_, vim_item)
                    -- Icons for different completion sources
                    local icons = {
                        Text = "󰊄",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰇽",
                        Variable = "󰂡",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "󰑭",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "󰈇",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "󰙅",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = "󰅲"
                    }

                    -- Set the icon based on the completion kind
                    vim_item.kind = string.format('%s %s', icons[vim_item.kind] or "󰃚", vim_item.kind)

                    return vim_item
                end
            }
        })

        -- Set configuration for specific filetypes (optional)
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({{
                name = "buffer"
            }})
        })

        -- Use buffer source for `/` and `?` (if you enabled `cmp-cmdline` earlier)
        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{
                name = "buffer"
            }}
        })

        -- Use cmdline & path source for ':' (if you enabled `cmp-cmdline` earlier)
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({{
                name = "path"
            }}, {{
                name = "cmdline"
            }})
        })
    end
}}
