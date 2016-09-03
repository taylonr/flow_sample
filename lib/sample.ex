defmodule Sample do
    def word_count(input) do
        alias Experimental.Flow
        File.stream!(input)
        |> Flow.from_enumerable()
        |> Flow.flat_map(&String.split(&1, ["\n", " "]))
        |> Flow.reject(&(String.length(&1) == 0))
        |> Flow.map(&String.downcase/1)
        |> Flow.partition()
        |> Flow.reduce(fn -> %{} end, fn word, acc ->
            Map.update(acc, word, 1, & &1 + 1)
        end)
        |> sort_list  
    end

    defp sort_list(val) do
        val
        |> Enum.to_list()
        |> Enum.sort(fn first, second -> elem(first, 1) > elem(second, 1) end)
    end

    def old_word_count(path) do
        File.stream!(path)
        |> Enum.flat_map(&String.split(&1, ["\n", " "]))
        |> Enum.reject(&(String.length(&1) == 0))
        |> Enum.map(&String.downcase/1)
        |> Enum.reduce(%{}, fn word, acc ->
            Map.update(acc, word, 1, & &1 + 1)
        end)
        |> sort_list()
    end

    def read(path) do
        File.read(path)
    end
end
