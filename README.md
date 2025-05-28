# Mix Reorder Migrations

A simple Mix task to reorder PostgreSQL migration files in `priv/repo/migrations/postgres` based on a predefined list order.

Migrations are timestamped by default, but if the names are changed to 'create_' name '.exs' they can be reorder if required using the mix task by simply changing the order of the list.

## Usage

If migrations start as:

```elixir
create_comments.exs
create_posts.exs
```

The reorder.ex can be updated to change the order list to:

```elixir
order = [
  "posts",
  "comments"
]
```

Then run:

```bash
mix reorder.migrations

```

Output:

```elixir
create_posts.exs
create_comments.exs
```
