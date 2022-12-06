defmodule Aoc2022.Day6 do
  @moduledoc """
  Advent of Code 2022, day 6.
  """
  import Aoc2022


  def data(key) do
    Map.get(
      %{example: "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
        ex2: "bvwbjplbgvbhsrlpgdmjqwftvncz",
        ex3: "nppdvjthqldpwncqszvftbrmjlhg",
        ex4: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
        ex5: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",
    puzzle: input("day6")
  }, key
    )
  end

  def part1(input) do
    data(input)
    |> scan(4)
  end

  def scan(stream, count) do
    <<first::size(8), second::size(8), third::size(8), fourth::size(8), rest::bitstring>> = stream
    cond do
      first != second && first != third && first != fourth && second != third && second != fourth && third != fourth -> count
      true -> [ _h | tail] = String.codepoints(stream)
              scan(Enum.join(tail), count+1)
    end
  end

  def part2(input) do
    data(input)
    |> scan2(14)
  end

  def scan2(stream, count) do
    unique_count = stream
            |> String.codepoints()
            |> Enum.take(14)
            |> Enum.uniq
            |> Enum.count

    if unique_count < 14 do
      [ _h | tail] = String.codepoints(stream)
      scan2(Enum.join(tail), count+1)
    else
      count
    end
  end
end
