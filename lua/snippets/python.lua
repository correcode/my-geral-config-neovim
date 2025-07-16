local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('main', {
    t({ 'if __name__ == "__main__":', '    ' }), i(1)
  }),
  s('print', {
    t('print('), i(1, '""'), t(')')
  }),
  s('for', {
    t('for '), i(1, 'i'), t(' in '), i(2, 'range()'), t(':'), t({ '', '    ' }), i(3)
  }),
  s('if', {
    t('if '), i(1, 'cond'), t(':'), t({ '', '    ' }), i(2)
  }),
} 