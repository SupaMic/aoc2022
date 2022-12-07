defmodule Aoc2022.Day7 do

import Aoc2022
  def data(key) do
    Map.get(%{
      example: """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
""",
puzzle: input("day7")
    }, key)

  end

  def part1(input) do
    data(input)
    |> String.split(~r/\n/, trim: true)
    |> Enum.reduce({[], %{}}, &parse_line/2)
    |> elem(1)
    |> IO.inspect(label: "tree")
    |> Enum.filter(fn {_k, v} -> v < 100000 end)
    |> IO.inspect(label: "filtered")
    |> Enum.reduce(0, fn {_k, v}, acc -> acc + v end)

  end

  def pop_last(list), do: Enum.take(list, length(list) - 1)

  def parse_line(<<"$ cd /">>, _acc), do: {["/"], %{"/" => 0}}
  def parse_line(<<"$ cd ..">>, {cur_path, tree}), do: {pop_last(cur_path), tree}
  def parse_line(<<"$ cd " <> data::binary>>, _acc = {path, tree}) do
      cur_path = path ++ [data]
      new_tree = %{Enum.join(cur_path, "/") => 0} |> Map.merge(tree, fn _k, v1, v2 -> v1 + v2 end)
     {cur_path, new_tree}
  end

  def parse_line(<<"$ ls">>, _acc = {path, tree}) do
    {path, tree}
  end

  def parse_line(<<"dir ", _data::binary>>, _acc = {path, tree}) do
    {path, tree}
  end

  def parse_line(<<data::binary>>, _acc = {cur_path, tree}) do
    [filesize, _filename] = String.split(data, " ")
    dir = Enum.join(cur_path, "/")
    {_old, new_tree} = Map.get_and_update(tree, dir, fn :nil -> {:nil, String.to_integer(filesize) }
                                                cur_val -> {cur_val, cur_val + String.to_integer(filesize) }
                                  end)
    {cur_path, new_tree}
  end

end
