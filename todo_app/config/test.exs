import Config

config :todo_app, TodoApp.Repo,
  adapter: Ecto.Adapters.SQLite3,
  database: "db/todo_app_test.sqlite3",
  pool_size: 1

config :todo_app, ecto_repos: [TodoApp.Repo]
