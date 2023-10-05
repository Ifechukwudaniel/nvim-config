return {
    cmd = {'solc', '--lsp', '--base-path', './', '--include-path', '$(forge remappings)'}
    filetypes = { "solidity", "yul" },
    root_dir =  vim.util.root_pattern("hardhat.config.js", "hardhat.config.ts", "foundry.toml", "remappings.txt", "truffle.js", "truffle-config.js", "ape-config.yaml", ".git", "package.json"),
    single_file_support = false
}
