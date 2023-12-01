defmodule Elf do
  def find_first(_, idx \\ 0, first \\ nil, last \\ nil)

  def find_first("", _, _, _) do
    0
  end

  def find_first(nil, _, _, _) do
    0
  end

  def find_first(word, idx, first, last) do
    if(idx == String.length(word)) do
      String.to_integer(Integer.to_string(first) <> Integer.to_string(last))
    else
      attempt = Integer.parse(String.at(word, idx))

      case {attempt, first} do
        {:error, f} ->
          find_first(word, idx + 1, f, last)

        {{val, _}, nil} ->
          find_first(word, idx + 1, val, val)

        {{val, _}, f} ->
          find_first(word, idx + 1, f, val)
      end
    end
  end
end

case(File.read("input.txt")) do
  {:ok, contents} ->
    x = Enum.map(String.split(contents, "\n"), &Elf.find_first/1) |> Enum.sum()
    IO.puts(x)
end
