# Elixir_Exploration

This repository contains multiple projects under the Elixir_Exploration repository.

## Projects

1. **cards**: This project simulates the creation of a deck, shuffling, and dealing of cards.
2. **identicon**: Similar to the GitHub profile page icon generation algorithm. Details can be found in the [README_doc](./identicon/README.md).
3. **elixir_auth**: This project provides authentication with GitHub, written in Phoenix and Elixir. It requires a GitHub App Access Token, a local PostgreSQL server, and the installation of the Phoenix framework and Elixir language. Refer to the [README_doc](./elixir_auth/README.md) for more information. Please note that there might be version-related issues described in the documentation.
4. **google_but_not_github**: This repository has not been tested yet.

## Table of Contents
- [Commands](#commands)
- [Test](#test)
- [Map](#map)
- [Hash](#hash)
- [Struct](#struct)
- [Array](#array)
- [Documentation](#documentation)

## Commands
- Running a project with mix:
  - Navigate to the elixir project folder: `iex -S mix`
- Dependency for documentation in `<mix.exs>`: `{:ex_doc, "~> 0.12"}`
- Generating documentation: Run `mix docs`, then navigate to the `doc` folder and open `index.html` for the generated documentation page.
- Documentation testing: Use `## Examples` within the documentation section to perform testing. Running `elixir test` will execute the example code and compare the output to the last line of the example.

## Test
- There are two types of tests: `doctests` under `@doc` and `test` under `ExUnit.Case`.
- Both types require running `mix test` in the project folder.
- `refute` is the opposite of `assert`.

## Map
- When accessing a created map, use an Atom key instead of a String key.
- Changes to maps do not happen in-place but create a new map.
- Example code for Map:
  ```elixir
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


## Hash (continued)

- Hashing with `:md5`:
  ```elixir
  iex(42)> hash = :crypto.hash(:md5, "banana")
  <<114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65>>

  iex(43)> Base.encode16(hash) 
  "72B302BF297A228A75730123EFEF7C41"

  iex(44)> :binary.bin_to_list(hash) 
  [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]

## Struct

## Array
- You can append a list of num with `++ [43, 12]`

## Documentation 
I created a whole document page for the Identicon project. It looks like this: <img width="839" alt="Screen Shot 2022-10-16 at 10 48 13 PM" src="https://user-images.githubusercontent.com/35544956/196079959-db064978-e6f9-4dd4-8817-e0cc0ce314ea.png">
