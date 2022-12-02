defmodule Aoc2022 do
  @moduledoc """
  `Aoc2022` is a module for Advent of Code 2022.
  """
  def input(filename) do
    {:ok, file} = File.read("lib/" <> filename <> ".txt")
    file
  end

  def input_to_list(input) do
    input
    |> String.split(",")
    |> Stream.map(&String.to_integer(&1))
    |> Enum.to_list()

    # |> IO.inspect(label: "input list")
  end

  def input_lines_to_list(input) do
    input
    |> String.split(~r/\n/, trim: true)

    # |> IO.inspect(label: "input list")
  end
end
