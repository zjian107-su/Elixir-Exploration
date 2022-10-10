defmodule Identicon.Image do
@moduledoc """
    Provides struct to store date properties of Image
  """

  @doc """
    return a struct with a default hex value of nil

    ## Examples

      iex> %Identicon.Image{}
      %Identicon.Image{hex: nil}
      iex> %Identicon.Image{hex: []}
      %Identicon.Image{hex: []}
  """
  defstruct hex: nil, color: nil
end
