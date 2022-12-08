defmodule Aoc2022.Day8 do

  import Aoc2022

  def data(key) do
    Map.get(%{
      example: """
30373
25512
65332
33549
35390
""",
      puzzle: input("day8")
    }, key)
  end

  def part1(input) do
    data(input)
    |> make_grid()
    |> count_visible()
  end

  def make_grid(input) do
    input
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(&String.codepoints/1)
    |> Enum.with_index(fn line, row ->
            line
            |> Enum.with_index(fn tree, col ->
                 Map.put(%{}, {row, col}, String.to_integer(tree) )
            end)
          end)
    |> Enum.reduce(%{}, fn row, acc ->
                          Enum.reduce(row, acc, fn tree, acc2 ->
                            Map.merge(tree, acc2)
                          end)
                        end)
  end

  def count_visible(grid) do
      Enum.reduce(grid, 0, fn tree, acc ->
          if(is_visible?(grid, tree)) do
            acc + 1
          else
            acc
          end
        end)
  end
  def is_visible?(grid, tree = {{row, col}, _height}) do
    {edge_row, edge_col} = grid_edges(grid)

    cond do
      row == 0 or col == 0 -> true
      row == edge_row or col == edge_col -> true
      visible?(grid, tree, :north) -> true
      visible?(grid, tree, :south) -> true
      visible?(grid, tree, :east) -> true
      visible?(grid, tree, :west) -> true
      true -> false
    end
  end

  def visible?(grid, tree = {{row, col}, height}, :north) do
      heights = for rows <- 0..(row-1) do Map.get(grid, {rows, col}) end
      Enum.max(heights) < height
  end

  def visible?(grid, _tree = {{row, col}, height}, :south) do
    {edge_row, _edge_col} = grid_edges(grid)
    heights = for rows <- (row+1)..edge_row do Map.get(grid, {rows, col}) end
    Enum.max(heights) < height
  end

  def visible?(grid, _tree = {{row, col}, height}, :west) do
    heights = for cols <- 0..(col-1) do Map.get(grid, {row, cols}) end
    Enum.max(heights) < height
  end

  def visible?(grid, _tree = {{row, col}, height}, :east) do
    {_edge_row, edge_col} = grid_edges(grid)
    heights = for cols <- (col+1)..edge_col do Map.get(grid, {row, cols}) end
    Enum.max(heights) < height
  end

  def grid_edges(grid) do
    {max, _height} = Enum.max_by(grid, fn {{row, col}, _height} -> {row, col} end)
    max
  end
end
