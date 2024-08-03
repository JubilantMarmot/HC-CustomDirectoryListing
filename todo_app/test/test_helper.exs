ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(TodoApp.Repo, :manual)

Mix.Task.run "ecto.create", ~w(-r TodoApp.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r TodoApp.Repo --quiet)
