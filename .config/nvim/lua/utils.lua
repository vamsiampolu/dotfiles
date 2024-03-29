local api = vim.api

local M = {}

local get_map_options = function(custom_options)
    local options = { noremap = true, silent = true }
    if custom_options then
        options = vim.tbl_extend("force", options, custom_options)
    end
    return options
end

M.buf_map = function(bufnr, mode, target, source, opts)
  -- bufnr is the result of calling :ls
    api.nvim_buf_set_keymap(bufnr or 0, mode, target, source, get_map_options(opts))
end

return M
