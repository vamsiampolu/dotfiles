local neoclip = require('neoclip')
local telescope = require('telescope')

telescope.setup {
  defaults = {
    dynamic_preview_title = true,
  } 
}

telescope.load_extension('neoclip')

neoclip.setup({
  enable_persistant_history = true,
  history = 20
})
