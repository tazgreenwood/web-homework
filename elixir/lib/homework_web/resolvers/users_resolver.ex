defmodule HomeworkWeb.Resolvers.UsersResolver do
  alias Homework.Users

  @doc """
  Get count of users rows
  """
  def count(_root, args, _info) do
    {:ok, Users.get_user_count(args)}
  end

  @doc """
  Get a user by id
  """
  def user(_parent, %{id: id}, _resolution) do
    case Users.get_user!(id) do
      nil ->
        {:error, "User ID #{id} not found"}
      user ->
        {:ok, user}
    end
  end

  @doc """
  Get a list of users
  """
  def users(_root, args, _info) do
    cond do
      Map.has_key?(args, :first_name) && Map.has_key?(args, :last_name) ->
        {:ok, Users.list_users_by_name(args)}
      Map.has_key?(args, :limit) && Map.has_key?(args, :skip) ->
        {:ok, Users.list_users_pagination(args)}
      true ->
        {:ok, Users.list_users(args)}
    end
  end

  @doc """
  Creates a user
  """
  def create_user(_root, args, _info) do
    case Users.create_user(args) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not create user: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a user for an id with args specified.
  """
  def update_user(_root, %{id: id} = args, _info) do
    user = Users.get_user!(id)

    case Users.update_user(user, args) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not update user: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a user for an id
  """
  def delete_user(_root, %{id: id}, _info) do
    user = Users.get_user!(id)

    case Users.delete_user(user) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not update user: #{inspect(error)}"}
    end
  end
end
