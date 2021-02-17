defmodule Homework.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Homework.Repo

  alias Homework.Transactions.Transaction

  def convert_to_decimal(transactions) do
    Enum.map(transactions, fn t ->
      amount = Map.get(t, :amount)
      a = Float.round(amount/100, 2)
      Map.put(t, :amount, a)
    end)
  end

  def convert_to_integer(t) do
    amount = Map.get(t, :amount)
    a = round(amount*100)
    Map.put(t, :amount, a)
  end

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions([])
      [%Transaction{}, ...]

  """
  def list_transactions(_args) do
    Repo.all(Transaction)
    |> convert_to_decimal()
  end

  @doc """
  Returns the count of transactions.

  ## Examples

      iex> list_transactions([])
      [%Transactions{}, ...]

  """
  def get_transaction_count(_args) do
    query = from t in Transaction, select: count(t.id, :distinct)
    Repo.one(query)
  end

    @doc """
  Returns the list of transactions with pagination.

  ## Examples

      iex> list_transactions([])
      [%Transactions{}, ...]

  """
  def list_transactions_pagination(%{limit: limit, skip: skip}) do
    Transaction
    |> limit(^limit)
    |> offset(^skip)
    |> Repo.all()
  end

  @doc """
  Returns the list of transactions for the last 30 days.

  ## Examples

      iex> list_transactions([])
      [%Transaction{}, ...]

  """
  def list_transactions_since(%{days: days}) do
    query = from t in Transaction,
            where: t.inserted_at > ago(^days, "day")
    Repo.all(query)
    |> convert_to_decimal()
  end

  @doc """
  Returns the list of transactions between min and max amounts.

  ## Examples

      iex> list_transactions([])
      [%Transaction{}, ...]

  """
  def list_transactions_min_max(%{min: min, max: max}) do
    query = from t in Transaction,
            where: t.amount > ^min and t.amount < ^max
    Repo.all(query)
    |> convert_to_decimal()
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id) do
    Repo.get!(Transaction, id)
    |> convert_to_decimal()
  end

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    new_attrs = convert_to_integer(attrs)
    %Transaction{}
    |> Transaction.changeset(new_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    new_attrs = convert_to_integer(attrs)
    transaction
    |> Transaction.changeset(new_attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end
end
