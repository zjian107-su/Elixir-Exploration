defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  String
  -> Get hash (MD5)
  -> Get List of numbers
  -> Get colors
  -> Build a grid of squares
  -> Convert to image(binary)
  -> Save image as a file
  """
  @type image :: %Identicon.Image{hex: [integer], color: {integer, integer, integer}, grid: [{integer, integer}], pixel_map: [{{integer, integer}, {integer, integer}}]}

  @spec main(String.t) :: {:ok} | {:error, String.t}
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
  Turns `input` to struct

  ## Examples

      iex> Identicon.hash_input("banana")
      %Identicon.Image{color: nil, grid: nil, hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], pixel_map: nil}
  """
  @spec hash_input(String.t) :: image
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    res = %Identicon.Image{hex: hex}
    res
  end

  @doc """
  Extracts first 3 values as R, G, B values

  ## Examples
      iex> temp = %Identicon.Image{ color: nil , grid: nil , hex: [193, 165, 41, 143, 147, 158, 135, 232, 249, 98, 165, 237, 252, 32, 105, 24] , pixel_map: nil}
      Identicon.pick_color(temp)
      %Identicon.Image{color: {193, 165, 41}, grid: nil,
      hex: [193, 165, 41, 143, 147, 158, 135, 232, 249, 98, 165, 237, 252, 32, 105,
      24], pixel_map: nil}
  """
  @spec pick_color(image) :: image
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Builds a 5x5 grid
  Note that the identicon is bilateral symmetry.
  The left-half of the image is a mirror image of the right half.

  Returns a tuple since we are going to filter hence need to know the location of each pixel.
  ## Examples
      iex> "Hi" |> hash_input |> pick_color |> build_grid
      %Identicon.Image{color: {193, 165, 41},
      grid: [{193, 0}, {165, 1}, {41, 2}, {165, 3}, {193, 4}, {143, 5}, {147, 6},
      {158, 7}, {147, 8}, {143, 9}, {135, 10}, {232, 11}, {249, 12}, {232, 13},
      {135, 14}, {98, 15}, {165, 16}, {237, 17}, {165, 18}, {98, 19}, {252, 20},
      {32, 21}, {105, 22}, {32, 23}, {252, 24}],
      hex: [193, 165, 41, 143, 147, 158, 135, 232, 249, 98, 165, 237, 252, 32, 105,
      24], pixel_map: nil}
  """
  @spec build_grid(image) :: image
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

  @doc """
  Filters to drop odd code in the grid.
  It's just an algorithm for the identicon.

  ## Examples
      iex> "Hi" |> hash_input |> pick_color |> build_grid |> filter_odd_squares
      %Identicon.Image{color: {193, 165, 41},
      grid: [{158, 7}, {232, 11}, {232, 13}, {98, 15}, {98, 19}, {252, 20}, {32, 21},
      {32, 23}, {252, 24}],
      hex: [193, 165, 41, 143, 147, 158, 135, 232, 249, 98, 165, 237, 252, 32, 105,
      24], pixel_map: nil}
  """
  @spec filter_odd_squares(image) :: image
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter grid, fn({code, _index}) -> rem(code, 2) == 0 end

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Creates a pixel map positions assuming the pixel size is 250 x 250
  In order to draw a box, we need a top-left corner ({integer, integer})
  and bottom-right corner ({integer, integer}),
  resulting in {top-left, bottom-right}.

  ## Examples

      iex> "Hi" |> hash_input |> pick_color |> build_grid |> filter_odd_squares |> build_pixel_map
      %Identicon.Image{color: {193, 165, 41},
      grid: [{158, 7}, {232, 11}, {232, 13}, {98, 15}, {98, 19}, {252, 20}, {32, 21},
      {32, 23}, {252, 24}],
      hex: [193, 165, 41, 143, 147, 158, 135, 232, 249, 98, 165, 237, 252, 32, 105,
      24],
      pixel_map: [{{100, 50}, {150, 100}}, {{50, 100}, {100, 150}},
      {{150, 100}, {200, 150}}, {{0, 150}, {50, 200}}, {{200, 150}, {250, 200}},
      {{0, 200}, {50, 250}}, {{50, 200}, {100, 250}}, {{150, 200}, {200, 250}},
      {{200, 200}, {250, 250}}]}

  """
  @spec build_pixel_map(image) :: image
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

  @doc """
  Draws image using `egd` erlang library
  """
  @spec draw_image(image) :: binary
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn{start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  @doc """
  Saves the binary image to a file
  """
  @spec save_image(image, String.t) :: {:ok} | {:error, String.t}
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  @doc """
  Append the first and the second item in a list

  ## Examples

      iex> Identicon.mirror_row([1,2,3,4,5,6])
      [1, 2, 3, 4, 5, 6, 2, 1]

  """

  @spec mirror_row(list()) :: list()
  def mirror_row(row) do
    len = length(row)
    if len >= 2 do
      [first, second | tail] = row
      row ++ [second, first]
    end
  end

  @doc """
  Remove the last item that is nil

  ## Examples

      iex> Identicon.remove_nil([1,2,3,nil])
      [1, 2, 3]
  """


  @spec remove_nil(list()) :: list()
  def remove_nil(aList) do
    if List.last(aList) == nil do
      aList = List.delete_at(aList, length(aList) - 1)
    end
  end

end
