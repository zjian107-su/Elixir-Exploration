# Elixir_Exploration

### Commands
- under the elixir project folder: `iex -S mix`
- dep for doc in <mix.exs>: `{:ex_doc, "~> 0.12"}`
- write doc for defmodule --> `mix docs` --> `cd doc` --> `open index.html` for free generated doc page
- Doc testing: within the doc section, you can use `## Examples` to do doc testing. When you run `elixir test`, you example could would be ran within the command. And the result would be compared to your last line of the example output.