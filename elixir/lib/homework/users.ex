defmodule Homework.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Homework.Repo

  alias Homework.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users([])
      [%User{}, ...]

  """
  def list_users(_args) do
    Repo.all(User)
  end

  @doc """
  Returns the count of users.

  ## Examples

      iex> list_users([])
      [%User{}, ...]

  """
  def get_user_count(_args) do
    query = from t in User, select: count(t.id, :distinct)
    Repo.one(query)
  end

    @doc """
  Returns the list of users with pagination.

  ## Examples

      iex> list_users([])
      [%User{}, ...]

  """
  def list_users_pagination(%{limit: limit, skip: skip}) do
    User
    |> limit(^limit)
    |> offset(^skip)
    |> Repo.all()
  end


  @doc """
  Returns the list of users that match name.

  ## Examples

      iex> list_users([])
      [%User{}, ...]

  """
  def list_users_by_name(%{first_name: first_name, last_name: last_name}) do
    query = from u in User,
            where: ilike(u.first_name, ^"%#{first_name}%") and ilike(u.last_name, ^"%#{last_name}%")
    Repo.all(query)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
