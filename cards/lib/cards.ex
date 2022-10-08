defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling cards
  """

  @doc """
    Returns a list of strings representing a deck of palying cards
  """
  def hello do
    :world
  end

  def hello_daniel do
    "Hi Daniellll!!"
  end

  def create_deck do
    values = ["Ace", "Two", "Three"]
    suits = ["Spades", "Clubs", "hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end
@doc """
  Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true
"""
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divedes a deck in a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

    ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist!"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

  def learn_map() do
    colors = %{primary: "Red"}
    IO.puts("The first item in colors is " <> colors.primary <> "!")
    colors = Map.put(colors, :primary, "Blue")
    IO.puts("After change, the first item in colors is now " <> colors.primary <> "!")
  end
end
