defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3)
      |> Enum.map(&mirror_row/1)
      |> remove_nil
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end


  def mirror_row(row) do
    len = length(row)
    if len >= 2 do
      [first, second | tail] = row
      row ++ [second, first]
    end
  end

  def remove_nil(aList) do
    if List.last(aList) == nil do
      aList = List.delete_at(aList, length(aList) - 1)
    end
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    res = %Identicon.Image{hex: hex}
    res
  end
end
