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

  def find_second("") do
    0
  end

  def find_second(nil) do
    0
  end

  def find_second(word) do
    w =
      String.replace(word, ~r/(one|two|three|four|five|six|seven|eight|nine)/, fn match ->
        case match do
          "one" -> "1"
          "two" -> "2"
          "three" -> "3"
          "four" -> "4"
          "five" -> "5"
          "six" -> "6"
          "seven" -> "7"
          "eight" -> "8"
          "nine" -> "9"
        end
      end)
      |> String.replace(~r/[a-z]/, "")

    parsed = String.to_integer(String.at(w, 0) <> String.at(w, String.length(w) - 1))
    IO.inspect({parsed, word})
    parsed
  end
end

case(File.read("input.txt")) do
  {:ok, contents} ->
    x = Enum.map(String.split(contents, "\n"), &Elf.find_second/1) |> Enum.sum()
    IO.puts(x)
end
