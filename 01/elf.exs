case(File.read("input.txt")) do
  {:ok, contents} ->
    total =
      String.split(contents, "\n")
      |> Enum.map(&String.split(&1, ""))
      |> Enum.map(fn [first | rest] -> {first, Enum.at(rest, -1)} end)
      |> Enum.map(fn {first, last} -> String.to_integer(first) + String.to_integer(last) end)
      |> Enum.reduce(0, &+/2)

    IO.inspect(total)

  {_, _} ->
    IO.inspect("Can't read file")
end
