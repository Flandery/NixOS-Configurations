 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#fcfae4',
    base01 = '#f0efd8',
    base02 = '#ebe9d3',
    base03 = '#78795b',
    base04 = '#47492e',
    base05 = '#1c1c0f',
    base06 = '#1c1c0f',
    base07 = '#1c1c0f',
    base08 = '#ba1a1a',
    base09 = '#5e621b',
    base0A = '#855318',
    base0B = '#8a5100',
    base0C = '#c7cc79',
    base0D = '#ffb86f',
    base0E = '#fcb975',
    base0F = '#ffdcbd',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#1c1c0f',          bg = '#fcfae4' })
  hi('TelescopeBorder',         { fg = '#78795b',             bg = '#fcfae4' })
  hi('TelescopePromptNormal',   { fg = '#1c1c0f',          bg = '#fcfae4' })
  hi('TelescopePromptBorder',   { fg = '#78795b',             bg = '#fcfae4' })
  hi('TelescopePromptPrefix',   { fg = '#8a5100',             bg = '#fcfae4' })
  hi('TelescopePromptCounter',  { fg = '#47492e',  bg = '#fcfae4' })
  hi('TelescopePromptTitle',    { fg = '#fcfae4',             bg = '#8a5100' })
  hi('TelescopePreviewTitle',   { fg = '#fcfae4',             bg = '#855318' })
  hi('TelescopeResultsTitle',   { fg = '#fcfae4',             bg = '#5e621b' })
  hi('TelescopeSelection',      { fg = '#1c1c0f',          bg = '#ebe9d3' })
  hi('TelescopeSelectionCaret', { fg = '#8a5100',             bg = '#ebe9d3' })
  hi('TelescopeMatching',       { fg = '#8a5100',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#1c1c0f',          bg = '#fcfae4' })
  hi('MiniPickBorder',         { fg = '#78795b',             bg = '#fcfae4' })
  hi('MiniPickPrompt',   { fg = '#1c1c0f',          bg = '#fcfae4' })
  hi('MiniPickPromptPrefix',   { fg = '#8a5100',             bg = '#fcfae4' })
  hi('MiniPickBorderText',    { fg = '#fcfae4',             bg = '#8a5100' })
  hi('MiniPickMatchCurrent',      { fg = '#1c1c0f',          bg = '#ebe9d3' })
  hi('MiniPickPromptCaret', { fg = '#8a5100',             bg = '#ebe9d3' })
  hi('MiniPickMatchRanges',       { fg = '#8a5100',             bold = true })
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
