 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#fcfaea',
    base01 = '#f1eedf',
    base02 = '#ebe9da',
    base03 = '#787864',
    base04 = '#474836',
    base05 = '#1c1c13',
    base06 = '#1c1c13',
    base07 = '#1c1c13',
    base08 = '#ba1a1a',
    base09 = '#0f6b1f',
    base0A = '#5e622e',
    base0B = '#5b6000',
    base0C = '#84da80',
    base0D = '#c5ce48',
    base0E = '#c7cb8d',
    base0F = '#e4e7a6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#1c1c13',          bg = '#fcfaea' })
  hi('TelescopeBorder',         { fg = '#787864',             bg = '#fcfaea' })
  hi('TelescopePromptNormal',   { fg = '#1c1c13',          bg = '#fcfaea' })
  hi('TelescopePromptBorder',   { fg = '#787864',             bg = '#fcfaea' })
  hi('TelescopePromptPrefix',   { fg = '#5b6000',             bg = '#fcfaea' })
  hi('TelescopePromptCounter',  { fg = '#474836',  bg = '#fcfaea' })
  hi('TelescopePromptTitle',    { fg = '#fcfaea',             bg = '#5b6000' })
  hi('TelescopePreviewTitle',   { fg = '#fcfaea',             bg = '#5e622e' })
  hi('TelescopeResultsTitle',   { fg = '#fcfaea',             bg = '#0f6b1f' })
  hi('TelescopeSelection',      { fg = '#1c1c13',          bg = '#ebe9da' })
  hi('TelescopeSelectionCaret', { fg = '#5b6000',             bg = '#ebe9da' })
  hi('TelescopeMatching',       { fg = '#5b6000',             bold = true })
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
