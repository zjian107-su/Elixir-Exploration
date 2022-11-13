# Cards

Provides methods for creating and handling a deck of cards. For full documentation [click here](https://hexdocs.pm/playing_cards/Cards.html#content).

- [Cards](#cards)
  - [Getting Started](#getting-started)
  - [Summary](#summary)
    - [Functions](#functions)
  - [License](#license)

## Getting Started

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cards` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cards, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/cards>.

## Summary

### Functions

```[contains?(deck, card)]```

Returns  `true`  if deck contains a given card, otherwise  `false`.

```[create_deck()]```

Generates a standard 52-card deck as a list of strings.

```[deal(deck, hand_size)]```

Divides a deck into a hand and the remainder of the deck. The  `hand_size`  argument indicates how many cards should be in the hand. Returns a tuple with two lists. The first list contains  `number`  of cards split from the  `deck`. The second list contains the remaining  `deck`  of cards. This function utilizes the Elixir Enum module split function.

```[hand(hand_size)]```

Returns a tuple with  `{hand, deck}`  where hand has  `hand_size`  number of cards.

```[load(filename)]```

Load a deck of cards from the specified  `filename`. If the file does not exist

```[save(deck, filename)]```

Save a  `deck`  of cards to the specified  `filename`  for future access.

```[shuffle(deck)]```

Shuffles a deck of cards using the Elixir Enum module shuffle function.

## License
MIT
