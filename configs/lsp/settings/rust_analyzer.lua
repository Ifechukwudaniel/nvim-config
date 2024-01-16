return {
    filetypes = { "rust" },
    root_dir = require("lspconfig").util.root_pattern("Cargo.toml"),
    settings = {
     ["rust-analyzer"] ={
         imports = {
          granularity = {
              group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
          allFeatures = true,
        },
        procMacro = {
          enable = true
        },
     }, 
  },
}
