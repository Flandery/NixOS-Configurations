 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1d1c21',
    base01 = '#302f37',
    base02 = '#2b2a32',
    base03 = '#66676e',
    base04 = '#b1b0b5',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#9a8fa3',
    base0A = '#948da5',
    base0B = '#9a98b3',
    base0C = '#c0b9c5',
    base0D = '#b7b6c9',
    base0E = '#bcb8c7',
    base0F = '#d7d4dd',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#1d1c21' })
  hi('TelescopeBorder',         { fg = '#66676e',             bg = '#1d1c21' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#1d1c21' })
  hi('TelescopePromptBorder',   { fg = '#66676e',             bg = '#1d1c21' })
  hi('TelescopePromptPrefix',   { fg = '#9a98b3',             bg = '#1d1c21' })
  hi('TelescopePromptCounter',  { fg = '#b1b0b5',  bg = '#1d1c21' })
  hi('TelescopePromptTitle',    { fg = '#1d1c21',             bg = '#9a98b3' })
  hi('TelescopePreviewTitle',   { fg = '#1d1c21',             bg = '#948da5' })
  hi('TelescopeResultsTitle',   { fg = '#1d1c21',             bg = '#9a8fa3' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#2b2a32' })
  hi('TelescopeSelectionCaret', { fg = '#9a98b3',             bg = '#2b2a32' })
  hi('TelescopeMatching',       { fg = '#9a98b3',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#1d1c21' })
  hi('MiniPickBorder',         { fg = '#66676e',             bg = '#1d1c21' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#1d1c21' })
  hi('MiniPickPromptPrefix',   { fg = '#9a98b3',             bg = '#1d1c21' })
  hi('MiniPickBorderText',    { fg = '#1d1c21',             bg = '#9a98b3' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#2b2a32' })
  hi('MiniPickPromptCaret', { fg = '#9a98b3',             bg = '#2b2a32' })
  hi('MiniPickMatchRanges',       { fg = '#9a98b3',             bold = true })
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
