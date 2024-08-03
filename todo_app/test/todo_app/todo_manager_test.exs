Ecto.Adapters.SQL.Sandbox.mode(TodoApp.Repo, :manual)

defmodule TodoApp.TodoManagerTest do
  use TodoApp.DataCase  # Use this if you have a DataCase module that sets up the test database

  alias TodoApp.{TodoManager, Todo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TodoApp.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(TodoApp.Repo, {:shared, self()})
    :ok
  end

  describe "list_todos/0" do
    test "returns all todos" do
      todo = %Todo{title: "Test Todo", description: "Test Description"}
      TodoApp.Repo.insert!(todo)

      assert [todo] = TodoManager.list_todos()
    end
  end

  describe "get_todo!/1" do
    test "returns the todo with given id" do
      todo = %Todo{title: "Test Todo", description: "Test Description"}
      {:ok, todo} = TodoApp.Repo.insert(todo)

      assert todo == TodoManager.get_todo!(todo.id)
    end

    test "raises error if todo with given id does not exist" do
      assert_raise Ecto.NoResultsError, fn ->
        TodoManager.get_todo!(12345)
      end
    end
  end

  describe "create_todo/1" do
    test "creates a todo with valid attributes" do
      attrs = %{title: "New Todo", description: "New Description"}

      assert {:ok, %Todo{} = todo} = TodoManager.create_todo(attrs)
      assert todo.title == "New Todo"
      assert todo.description == "New Description"
    end

    test "returns an error changeset with invalid attributes" do
      attrs = %{title: nil}

      assert {:error, %Ecto.Changeset{}} = TodoManager.create_todo(attrs)
    end
  end

  describe "update_todo/2" do
    test "updates the todo with given attributes" do
      todo = %Todo{title: "Old Title", description: "Old Description"}
      {:ok, todo} = TodoApp.Repo.insert(todo)
      attrs = %{title: "Updated Title"}

      assert {:ok, %Todo{} = updated_todo} = TodoManager.update_todo(todo, attrs)
      assert updated_todo.title == "Updated Title"
      assert updated_todo.description == "Old Description"
    end
  end

  describe "delete_todo/1" do
    test "deletes the todo" do
      todo = %Todo{title: "Todo to be deleted", description: "Some Description"}
      {:ok, todo} = TodoApp.Repo.insert(todo)

      assert {:ok, %Todo{}} = TodoManager.delete_todo(todo)
      assert TodoManager.get_todo!(todo.id) == nil
    end
  end
end
