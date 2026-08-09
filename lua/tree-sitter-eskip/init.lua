local M = {}

function M.setup()
  -- Register the parser with nvim-treesitter
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if ok then
    parsers.eskip = {
      install_info = {
        url = "https://github.com/carloluis/tree-sitter-eskip",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "eskip",
    }
  end

  -- Associate the eskip filetype with the tree-sitter language
  vim.treesitter.language.register("eskip", "eskip")

  -- Enable treesitter highlighting for eskip buffers
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "eskip",
    callback = function(ev)
      vim.treesitter.start(ev.buf, "eskip")
    end,
    desc = "Enable tree-sitter for eskip",
  })
end

return M
