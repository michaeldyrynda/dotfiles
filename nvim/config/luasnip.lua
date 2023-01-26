local ls = require('luasnip')

ls.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
})

ls.add_snippets('php', {
  ls.parser.parse_snippet('class', 'class $1\n{\n    $0\n}'),
  ls.parser.parse_snippet('pubf', 'public function $1($2): $3\n{\n    $0\n}'),
  ls.parser.parse_snippet('prif', 'private function $1($2): $3\n{\n    $0\n}'),
  ls.parser.parse_snippet('prof', 'protected function $1($2): $3\n{\n    $0\n}'),
  ls.parser.parse_snippet('testt', 'public function test_$1()\n{\n    $0\n}'),
  ls.parser.parse_snippet('testa', '/** @test */\npublic function $1()\n{\n    $0\n}'),
})
