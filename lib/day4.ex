defmodule Aoc2022.Day4 do
  @moduledoc """
  Advent of Code 2022, day 4.
"""
import Aoc2022

  def data(input) do
    Map.get(
      %{
        puzzle: input("day4"),
        example: """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
  """
      },
      input
    )
  end

  def part1(input) do
    data(input)
    |> input_lines_to_list()
    |> Enum.reduce(0, fn sectors, acc ->
          [sector_a, sector_b] = String.split(sectors, ",", trim: true)
                    |> Enum.map(&sector_mapset/1)
                    #|> IO.inspect(label: "sector_pair")

          intersection = MapSet.intersection(sector_a, sector_b)
                         # |> IO.inspect(label: "intersection")

          cond do
            MapSet.size(intersection) == MapSet.size(sector_a) -> acc + 1
            MapSet.size(intersection) == MapSet.size(sector_b) -> acc + 1
            true -> acc
          end
        end)

  end

  def sector_mapset(sector) do
    [a, b] = String.split(sector, "-", trim: true)
             |> Enum.map(&String.to_integer/1)

    MapSet.new(a..b)
  end

end
