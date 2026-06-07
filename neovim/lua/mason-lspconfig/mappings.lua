local M = {}

function M.get_mason_map()
  return require("mason-lspconfig.mappings.server")
end

return M
