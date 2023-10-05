return {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  flags = {
    debounce_text_changes = 150,
  },
  init_options = {
    preferences = {
      disableSuggestions = false,
    }
  } 
}
