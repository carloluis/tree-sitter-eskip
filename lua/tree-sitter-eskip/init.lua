local M = {}

local function register_parser()
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
end

-- Register now (covers the initial load) and re-register after every
-- TSUpdate, because nvim-treesitter wipes and re-requires its parsers
-- table inside reload_parsers() before running :TSInstall.
register_parser()
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = register_parser,
  desc = "Re-register eskip parser after nvim-treesitter reload",
})

function M.setup()
  -- Bind the eskip filetype to the tree-sitter language name
  vim.treesitter.language.register("eskip", "eskip")
  
  -- Enable highlighting for eskip buffers only when the parser is installed
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "eskip",
    callback = function(ev)
      local has_parser = pcall(vim.treesitter.language.inspect, "eskip")
      if has_parser then
        vim.treesitter.start(ev.buf, "eskip")
      end
    end,
    desc = "Enable tree-sitter highlighting for eskip",
  })
end

return M
