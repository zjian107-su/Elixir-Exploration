defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 12
  end

  test "shuffling a deck randomize it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
  # Comment: Singular assertion test
  # test "The Trueth" do
  #   assert 1 + 1 == 3
  # end



end
