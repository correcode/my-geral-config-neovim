local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('func', {
    t('function '), i(1, 'name'), t('('), i(2), t(')'), t({ '', '  ' }), i(3), t({ '', 'end' })
  }),
  s('print', {
    t('print('), i(1, '""'), t(')')
  }),
  s('for', {
    t('for '), i(1, 'i'), t(' = '), i(2, '1'), t(', '), i(3, 'n'), t(' do'), t({ '', '  ' }), i(4), t({ '', 'end' })
  }),
  s('if', {
    t('if '), i(1, 'cond'), t(' then'), t({ '', '  ' }), i(2), t({ '', 'end' })
  }),
} 