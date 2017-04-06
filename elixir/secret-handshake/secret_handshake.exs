defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @bits_map [
    "1": "wink",
    "10": "double blink",
    "100": "close your eyes",
    "1000": "jump",
  ]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code |> Integer.to_charlist(2) |> handshaking
  end

  def handshaking(code) do
    code |> set_lower_5_bits |> Enum.slice(-5, 5) |> action
  end

  def set_lower_5_bits(code) do
    if length(code) >= 5 do
      code
    else
      code = '0' ++ code
      set_lower_5_bits(code)
    end
  end

  def action(code) do
    [r, _, _, _, _] = code
    case r do
      ?1 -> decode_bits(code, @bits_map)
      ?0 -> decode_bits(code, Enum.reverse @bits_map)
    end
  end

  def decode_bits(code, bits_map) do
    [_, j, c, d, w] = code
    Enum.reduce(bits_map, [], fn(bit, acc) ->
      case elem(bit, 0) do
        :"1" -> if w == ?1, do: [@bits_map[:"1"] | acc], else: acc
        :"10" -> if d == ?1, do: [@bits_map[:"10"] | acc], else: acc
        :"100" -> if c == ?1, do: [@bits_map[:"100"] | acc], else: acc
        :"1000" -> if j == ?1, do: [@bits_map[:"1000"] | acc], else: acc
      end
    end)
  end
end
