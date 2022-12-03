defmodule Aoc2022.Day2 do
  @moduledoc """
  Advent of Code 2022, day 2.
  """
  import Aoc2022

  def data do
     %{
       puzzle: input("day2"),
       example: """
A Y
B X
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

  def part2(input) do
    data()
    |> Map.get(input)
    |> input_lines_to_list()
    |> Enum.map(&match_score(&1, :p2))
    |> IO.inspect(label: "part2")
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

  def match_score(match_string, :p2) do
    [you, me] = match_string
      |> IO.inspect(label: "match_string")
      |> String.split(" ")
      |> Enum.map(&Map.get(rps_values(:p2), &1))
      |> IO.inspect(label: "match values")

    case [you, me] do
      [:r, :win] -> rps_points(:p) + match_points(:win)
      [:r, :lose] -> rps_points(:s) + match_points(:lose)
      [:r, :draw] -> rps_points(:r) + match_points(:draw)
      [:p, :win] -> rps_points(:s) + match_points(:win)
      [:p, :lose] -> rps_points(:r) + match_points(:lose)
      [:p, :draw] -> rps_points(:p) + match_points(:draw)
      [:s, :win] -> rps_points(:r) + match_points(:win)
      [:s, :lose] -> rps_points(:p) + match_points(:lose)
      [:s, :draw] -> rps_points(:s) + match_points(:draw)
    end
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

  def rps_values(:p2) do
    %{
      "A" => :r,
      "B" => :p,
      "C" => :s,
      "X" => :lose,
      "Y" => :draw,
      "Z" => :win
    }
  end

  def rps_points do
    %{
      :r => 1,
      :p => 2,
      :s => 3
    }
  end

  def rps_points(key) do
    Map.get(%{
      :r => 1,
      :p => 2,
      :s => 3
    }, key)
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
