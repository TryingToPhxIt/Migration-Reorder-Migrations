defmodule Mix.Tasks.Reorder.Migrations do
  @moduledoc """
  Reorders the migration list

  Command
  
    mix reorder.migrations

  """

  use Mix.Task

  @shortdoc "Reorders priv/repo/migrations/postgres based on the list order"

  def run(_args) do
    path  = "priv/repo/migrations/postgres"
    order = [
      "admins", 
      "users",
      "posts",
      "comments",
    ]

    order_index =
      order
      |> Enum.with_index(1)
      |> Enum.into(%{}, fn {name, idx} ->
        {"create_#{name}.exs", idx}
      end)

    path
    |> File.ls!()
    |> Enum.filter(&Regex.match?(~r/^\d+_create_.*\.exs$/, &1))
    |> Enum.sort_by(fn file ->
      Map.get(order_index, String.split(file, "_", parts: 2) |> List.last(), 999)
    end)
    |> Enum.with_index(1)
    |> Enum.each(fn {file, new_idx} ->
      [_old, suffix] = String.split(file, "_", parts: 2)
      new_name = "#{Integer.to_string(new_idx) |> String.pad_leading(2, "0")}_#{suffix}"
      File.rename!(Path.join(path, file), Path.join(path, new_name))
    end)
  end
end
