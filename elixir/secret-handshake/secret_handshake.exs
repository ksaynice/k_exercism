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

  use Bitwise

  @dict %{1 => "wink", 2 => "double blink", 4 => "close your eyes", 8 => "jump"}

  @spec commands(code :: integer) :: list(String.t())

  def commands(code) do
    actions = @dict |> Enum.filter_map(fn{k, _v} -> ((code &&& k) == k) end, &(elem(&1, 1)))
    if code > 16, do: Enum.reverse(actions), else: actions
  end
end
