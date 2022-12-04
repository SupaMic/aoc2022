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

end
