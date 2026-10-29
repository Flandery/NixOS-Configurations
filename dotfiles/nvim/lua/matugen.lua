 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131407',
    base01 = '#202013',
    base02 = '#2a2b1c',
    base03 = '#929373',
    base04 = '#c8c9a6',
    base05 = '#e5e4cd',
    base06 = '#e5e4cd',
    base07 = '#e5e4cd',
    base08 = '#ffb4ab',
    base09 = '#c7cc79',
    base0A = '#fcb975',
    base0B = '#ffb86f',
    base0C = '#c7cc79',
    base0D = '#ffb86f',
    base0E = '#fcb975',
    base0F = '#ffdcbd',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e5e4cd',          bg = '#131407' })
  hi('TelescopeBorder',         { fg = '#929373',             bg = '#131407' })
  hi('TelescopePromptNormal',   { fg = '#e5e4cd',          bg = '#131407' })
  hi('TelescopePromptBorder',   { fg = '#929373',             bg = '#131407' })
  hi('TelescopePromptPrefix',   { fg = '#ffb86f',             bg = '#131407' })
  hi('TelescopePromptCounter',  { fg = '#c8c9a6',  bg = '#131407' })
  hi('TelescopePromptTitle',    { fg = '#131407',             bg = '#ffb86f' })
  hi('TelescopePreviewTitle',   { fg = '#131407',             bg = '#fcb975' })
  hi('TelescopeResultsTitle',   { fg = '#131407',             bg = '#c7cc79' })
  hi('TelescopeSelection',      { fg = '#e5e4cd',          bg = '#2a2b1c' })
  hi('TelescopeSelectionCaret', { fg = '#ffb86f',             bg = '#2a2b1c' })
  hi('TelescopeMatching',       { fg = '#ffb86f',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e5e4cd',          bg = '#131407' })
  hi('MiniPickBorder',         { fg = '#929373',             bg = '#131407' })
  hi('MiniPickPrompt',   { fg = '#e5e4cd',          bg = '#131407' })
  hi('MiniPickPromptPrefix',   { fg = '#ffb86f',             bg = '#131407' })
  hi('MiniPickBorderText',    { fg = '#131407',             bg = '#ffb86f' })
  hi('MiniPickMatchCurrent',      { fg = '#e5e4cd',          bg = '#2a2b1c' })
  hi('MiniPickPromptCaret', { fg = '#ffb86f',             bg = '#2a2b1c' })
  hi('MiniPickMatchRanges',       { fg = '#ffb86f',             bold = true })
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
