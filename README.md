# Elixir_Exploration

There are currently two projects under the current repository. 
1. cards - simulation of creating a deck, shuffling, dealing cards and so on.
2. identicon - similar to the GitHub profile page icon generation algorithm. For example, `https://github.com/programmer12`

### Commands
- under the elixir project folder: `iex -S mix`
- dep for doc in <mix.exs>: `{:ex_doc, "~> 0.12"}`
- write doc for defmodule --> `mix docs` --> `cd doc` --> `open index.html` for free generated doc page
- Doc testing: within the doc section, you can use `## Examples` to do doc testing. When you run `elixir test`, you example could would be ran within the command. And the result would be compared to your last line of the example output.

### Test
- There are 2 kind of tests. They are `doctests` under `@doc` and `test` under `ExUnit.Case`.
- They all require you to run `mix test` under the project folder.

- `refute` would be the opposite of `assert`

### Map
- When you try to access your created map, your key should be an Atom, NOT a String. 
- Map changes do not change in-place, but create a new map.
- Change colors value: `%{colors | primary: "blue"}` OR `Map.put(colors, :primary, "Blue")`
- Code example for Map
  ``` elixir
    iex(29)> colors00 = [{:primary, "red"}, {:secondary, "green"}] 
    [primary: "red", secondary: "green"]
    iex(30)> colors00[:primary]
    "red"

    colors01 = [primary: "red", secodnary: "blue"]
    [primary: "red", secodnary: "blue"]
    colors01[:primary]
    "red"

    colors02 = [primary: "red", primary: "red"]
    [primary: "red", primary: "red"]
    iex(38)> colors02[:primary]                         
    "red"

    iex(39)> colors03 = [primary: "red", primary: "pink"]
    [primary: "red", primary: "pink"]
    iex(40)> colors03[:primary]                          
    "red"
  ```

- If `[]` is the last argument, you can ignore them, or even without `()` for example: `query = User.find_where([where: user.age > 10, where: user.subscribed == true])` could be `query = User.find_where where: user.age > 10, where: user.subscribed == true` 

### Hash
- Hash with ":md5"
  ```
  iex(42)> hash = :crypto.hash(:md5, "banana")
  <<114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65>>
  iex(43)> Base.encode16(hash) 
  "72B302BF297A228A75730123EFEF7C41"
  iex(44)> :binary.bin_to_list(hash) 
  [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
  iex(45)> 
  ```

### Struct

### Array
- You can append a list of num with `++ [43, 12]`