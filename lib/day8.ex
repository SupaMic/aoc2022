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

  def part2(input) do
    :timer.tc(fn ->
        data(input)
        |> make_grid()
        |> scenic_scores()
        |> Enum.max()
    end)
  end

  def scenic_scores(grid) do
    {edge_row, edge_col} = grid_edges(grid)
    Enum.reduce(grid, [], fn tree = {{row, col}, height}, acc ->
      cond do
        row == 0 or col == 0 or row == edge_row or col == edge_col -> acc
        #height < 7 -> acc
        true -> [scenic_score(grid, tree) | acc]
      end
    end)
  end

  def tally(list, height, _direction) do
    list
    |> Enum.split_while(&(&1 < height))
    |> then(fn {shorter, []} -> shorter
               {shorter, [h | _rest]} -> shorter ++ [h]
              end )
    |> Enum.count()
  end

  def scenic_score(grid, _tree = {{row, col}, height}) do
    {edge_row, edge_col} = grid_edges(grid)

    north = for rows <- (row-1)..0 do Map.get(grid, {rows, col}) end
            |> tally(height, "north")

    south = for rows <- (row+1)..edge_row do Map.get(grid, {rows, col}) end
            |> tally(height, "south")

    east = for cols <- (col+1)..edge_col do Map.get(grid, {row, cols}) end
            |> tally(height, "east")

    west = for cols <- (col-1)..0 do Map.get(grid, {row, cols}) end
            |> tally(height, "west")

    north * west * east * south
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
