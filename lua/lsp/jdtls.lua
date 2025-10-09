vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        local config = {
            cmd = {"java", "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4",
                   "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL",
                   "-Xms1g", "--add-modules=ALL-SYSTEM", "--add-opens", "java.base/java.util=ALL-UNNAMED",
                   "--add-opens", "java.base/java.lang=ALL-UNNAMED", "-jar",
                   vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"), "-configuration",
                   jdtls_path .. "/config_linux", "-data", vim.fn.stdpath("cache") .. "/jdtls-workspace"},
            root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"})
        }
        require("jdtls").start_or_attach(config)
    end
})
