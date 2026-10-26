-- 关闭 blink.cmp 的自动联想
-- 1) 打字时不再自动弹出补全菜单（需要时按 <C-space> 手动弹出）
-- 2) 关闭“幽灵文本”（光标后面那截半透明的行内补全预览）
return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          auto_show = false,
          -- 如果只是嫌弹得太快，可以改成只延迟弹出：
          -- auto_show_delay_ms = 500,
        },
        -- 行内半透明预览（ghost text）
        ghost_text = { enabled = false },
      },
      -- 命令行 ":" 模式的设置（LazyVim 默认在这里也开了自动弹出和幽灵文本）
      cmdline = {
        completion = {
          ghost_text = { enabled = false },
          -- 如需连命令行自动弹出菜单也关掉，取消下一行注释：
          -- menu = { auto_show = false },
        },
      },
    },
    -- 如果想彻底禁用补全引擎（连 <C-space> 手动触发、命令行补全都没有），
    -- 删掉上面的 opts 块，改用下面这一行：
    -- enabled = false,
  },
}