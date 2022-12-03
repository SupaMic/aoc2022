defmodule Aoc2022.Day3 do
  @moduledoc """
  Advent of Code 2022, day 3.
  """

  import Aoc2022

  def data(key) do
    Map.get(
    %{
      puzzle: input("day3"),
      example: """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""
    }, key)
  end


  def part1(input) do
    data(input)
    |> input_lines_to_list()
    |> Enum.map(&compartmentalize(&1))
    |> Enum.map(&find_pair(&1))
    |> Enum.map(&priority(&1))
    |> Enum.sum()

  end

  def find_pair({a, b}) do
    intersection =
      MapSet.intersection(make_mapset(a), make_mapset(b))
      |> MapSet.to_list()

    "#{intersection}"
  end

  def make_mapset(string) do
    string
    |> String.to_charlist()
    |> MapSet.new()
  end
  def compartmentalize(rucksack) do
    rucksack
    |> String.split_at((String.length(rucksack)/2 |> trunc))
  end

  def priority(key) do
    Map.get(%{
      "a" => 1,
      "b" => 2,
      "c" => 3,
      "d" => 4,
      "e" => 5,
      "f" => 6,
      "g" => 7,
      "h" => 8,
      "i" => 9,
      "j" => 10,
      "k" => 11,
      "l" => 12,
      "m" => 13,
      "n" => 14,
      "o" => 15,
      "p" => 16,
      "q" => 17,
      "r" => 18,
      "s" => 19,
      "t" => 20,
      "u" => 21,
      "v" => 22,
      "w" => 23,
      "x" => 24,
      "y" => 25,
      "z" => 26,
      "A" => 27,
      "B" => 28,
      "C" => 29,
      "D" => 30,
      "E" => 31,
      "F" => 32,
      "G" => 33,
      "H" => 34,
      "I" => 35,
      "J" => 36,
      "K" => 37,
      "L" => 38,
      "M" => 39,
      "N" => 40,
      "O" => 41,
      "P" => 42,
      "Q" => 43,
      "R" => 44,
      "S" => 45,
      "T" => 46,
      "U" => 47,
      "V" => 48,
      "W" => 49,
      "X" => 50,
      "Y" => 51,
      "Z" => 52,
    }, key)
  end



end
