defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_sqaures
    |> build_pixel_map
  end


  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_sqaures(%Identicon.Image{grid: grid} = image) do
    Enum.filter(grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end)

    %Identicon.Image{image | grid: grid}

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
