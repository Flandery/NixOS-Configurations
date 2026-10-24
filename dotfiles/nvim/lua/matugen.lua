 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#14140b',
    base01 = '#202017',
    base02 = '#2a2b21',
    base03 = '#92927d',
    base04 = '#c8c8b1',
    base05 = '#e5e3d4',
    base06 = '#e5e3d4',
    base07 = '#e5e3d4',
    base08 = '#ffb4ab',
    base09 = '#84da80',
    base0A = '#c7cb8d',
    base0B = '#c5ce48',
    base0C = '#84da80',
    base0D = '#c5ce48',
    base0E = '#c7cb8d',
    base0F = '#e4e7a6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e5e3d4',          bg = '#14140b' })
  hi('TelescopeBorder',         { fg = '#92927d',             bg = '#14140b' })
  hi('TelescopePromptNormal',   { fg = '#e5e3d4',          bg = '#14140b' })
  hi('TelescopePromptBorder',   { fg = '#92927d',             bg = '#14140b' })
  hi('TelescopePromptPrefix',   { fg = '#c5ce48',             bg = '#14140b' })
  hi('TelescopePromptCounter',  { fg = '#c8c8b1',  bg = '#14140b' })
  hi('TelescopePromptTitle',    { fg = '#14140b',             bg = '#c5ce48' })
  hi('TelescopePreviewTitle',   { fg = '#14140b',             bg = '#c7cb8d' })
  hi('TelescopeResultsTitle',   { fg = '#14140b',             bg = '#84da80' })
  hi('TelescopeSelection',      { fg = '#e5e3d4',          bg = '#2a2b21' })
  hi('TelescopeSelectionCaret', { fg = '#c5ce48',             bg = '#2a2b21' })
  hi('TelescopeMatching',       { fg = '#c5ce48',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e5e3d4',          bg = '#14140b' })
  hi('MiniPickBorder',         { fg = '#92927d',             bg = '#14140b' })
  hi('MiniPickPrompt',   { fg = '#e5e3d4',          bg = '#14140b' })
  hi('MiniPickPromptPrefix',   { fg = '#c5ce48',             bg = '#14140b' })
  hi('MiniPickBorderText',    { fg = '#14140b',             bg = '#c5ce48' })
  hi('MiniPickMatchCurrent',      { fg = '#e5e3d4',          bg = '#2a2b21' })
  hi('MiniPickPromptCaret', { fg = '#c5ce48',             bg = '#2a2b21' })
  hi('MiniPickMatchRanges',       { fg = '#c5ce48',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
