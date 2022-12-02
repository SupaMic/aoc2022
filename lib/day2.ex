defmodule Aoc2022.Day2 do
  @moduledoc """
  `Aoc2022.Day1` is a module for Advent of Code 2022, day 1.
  """
  import Aoc2022

  def data do
     %{
       puzzle: input("day2"),
       example: """
A Y
B X
C Z
""",
      example2:
"""
C X
C X
C X
A Z
C X
C Z
C X
B Y
C X
C X
C X
B Y
C X
B Z
C Z
C X
C X
C Z
C Z
B Y
C Z
"""
     }
  end

  def part1(input) do
    data()
    |> Map.get(input)
    |> input_lines_to_list()
    |> Enum.map(&match_score/1)
    |> Enum.sum()

  end

  def match_score(match_string) do
    [you, me] = match_string
    |> IO.inspect(label: "match_string")
    |> String.split(" ")
    |> Enum.map(&Map.get(rps_values(), &1))
    |> IO.inspect(label: "match values")

    match = match_result([you, me])
    |> IO.inspect(label: "match_point")
    |> match_points()

    Map.get(rps_points(), me) + match
    |> IO.inspect(label: "total")
  end


  def rps_values do
    %{
      "A" => :r,
      "B" => :p,
      "C" => :s,
      "X" => :r,
      "Y" => :p,
      "Z" => :s
    }
  end

  def rps_points do
    %{
      :r => 1,
      :p => 2,
      :s => 3
    }
  end

  def match_result(match = [_you, _me]) do
    case match do
      [a, b] when a == b -> :draw
      [:r, :p] -> :win
      [:r, :s] -> :lose
      [:p, :r] -> :lose
      [:p, :s] -> :win
      [:s, :r] -> :win
      [:s, :p] -> :lose
    end
  end

  def match_points(result) do
    case result do
      :win -> 6
      :draw -> 3
      :lose -> 0
    end
  end

end
