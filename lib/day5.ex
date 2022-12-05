defmodule Aoc2022.Day5 do
  @moduledoc """
  Advent of Code 2022, day 5.
  """
  import Aoc2022

  def data(key) do
    Map.get(
      %{
        example:
"""
    [D]
[N] [C]
[Z] [M] [P]
  1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""",
        puzzle: input("day5")
      },
      key)
  end

  def part1(input) do
    [state, instructions] = data(input)|> String.split(~r/\n\n/, trim: false)

    state = transform_state(state)
    |> IO.inspect(label: "state end")

    instructions
    |> input_lines_to_list()
    |> Enum.reduce(state, fn instr, acc -> parse(instr, acc) end)
  end

  def part2(input) do
    [state, instructions] = data(input)|> String.split(~r/\n\n/, trim: false)

    state = transform_state(state)
    |> IO.inspect(label: "state end")

    instructions
    |> input_lines_to_list()
    |> Enum.reduce(state, fn instr, acc -> parse2(instr, acc) end)
  end

  def parse2(instruction, state) do
    list = instruction
    |> String.split(" ")
    |> IO.inspect(label: "instruction")

    {count, _} = List.pop_at(list, 1)
    {from, _} = List.pop_at(list, 3)
    {to, _} = List.pop_at(list, 5)

    move2(state, String.to_integer(from), String.to_integer(to), String.to_integer(count) )
  end

  def move2(state, from_stack, to_stack, count) do
      crates = state[from_stack]
      |> Enum.take(count)


      {_, new_state} = Map.get_and_update(state, from_stack, &({&1, Enum.drop(&1, count)}))
      {_, newer_state} = Map.get_and_update(new_state, to_stack, &({&1, List.flatten(List.insert_at(&1, 0, crates))}))
      newer_state |> IO.inspect(label: "new_state")
  end

  def parse(instruction, state) do
    list = instruction
    |> String.split(" ")
    |> IO.inspect(label: "instruction")

    {count, _} = List.pop_at(list, 1)
    {from, _} = List.pop_at(list, 3)
    {to, _} = List.pop_at(list, 5)

    move(state, String.to_integer(from), String.to_integer(to), String.to_integer(count) )
  end

  def move(state, from_stack, to_stack, 0), do: state
  def move(state, from_stack, to_stack, count) do
        [h | tail] = state[from_stack]
        {_, new_state} = Map.get_and_update(state, from_stack, &({&1, tail}))
        {_, newer_state} = Map.get_and_update(new_state, to_stack, &({&1, List.insert_at(&1, 0, h)}))
      move(newer_state, from_stack, to_stack, count-1)
  end

  def transform_state(state) do
    state
    |> IO.inspect(label: "state")
    |> String.split(~r/\n/, trim: true)
    |> Enum.map( fn line ->
                Regex.scan(~r/.{1,4}/, line)
                |> Enum.with_index(fn crate, index -> {index+1, List.to_string(crate)} end)
    end)
    |> IO.inspect(label: "stack and crates")
    |> Enum.map(fn row ->
            Enum.reduce(row, %{}, fn el, acc ->
                    {_k, v} = el
                    if (v != "    ") do
                      Map.merge(acc, mapify(el), fn _k, v1, v2 -> [v1] ++ [v2] end)
                    else
                      acc
                    end
            end)
        end)
    |> Enum.reduce(%{}, fn el, acc ->
        Map.merge(acc, el, fn _k, v1, v2 -> List.flatten([v1] ++ [v2]) end)

end)

  end

  def mapify({stack, crate}) do
    Enum.into([{stack, crate}], %{}, fn {stack, crate} -> {stack, strip(crate)} end)
  end

  def strip(crate) do
    crate
    |> String.replace("[", "")
    |> String.replace("]", "")
    |> String.replace(" ", "")
    |> String.replace(".", "")
  end

end
