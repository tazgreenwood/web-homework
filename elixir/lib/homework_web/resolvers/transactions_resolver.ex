defmodule HomeworkWeb.Resolvers.TransactionsResolver do
  alias Homework.Merchants
  alias Homework.Transactions
  alias Homework.Users

  @doc """
  Get count of transactions rows
  """
  def count(_root, args, _info) do
    {:ok, Transactions.get_transaction_count(args)}
  end

  @doc """
  Get merchant by id
  """
  def transaction(_root, %{id: id}, _info) do
    {:ok, Transactions.get_transaction!(id)}
  end

  @doc """
  Get a list of transcations
  """
  def transactions(_root, args, _info) do
    cond do
      Map.has_key?(args, :days) ->
        {:ok, Transactions.list_transactions_since(args)}
      Map.has_key?(args, :min) && Map.has_key?(args, :max) ->
        {:ok, Transactions.list_transactions_min_max(args)}
      Map.has_key?(args, :limit) && Map.has_key?(args, :skip) ->
        {:ok, Transactions.list_transactions_pagination(args)}
      true ->
        {:ok, Transactions.list_transactions(args)}
    end
  end

  @doc """
  Get the user associated with a transaction
  """
  def user(_root, _args, %{source: %{user_id: user_id}}) do
    {:ok, Users.get_user!(user_id)}
  end

  @doc """
  Get the merchant associated with a transaction
  """
  def merchant(_root, _args, %{source: %{merchant_id: merchant_id}}) do
    {:ok, Merchants.get_merchant!(merchant_id)}
  end

  @doc """
  Create a new transaction
  """
  def create_transaction(_root, args, _info) do
    case Transactions.create_transaction(args) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not create transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a transaction for an id with args specified.
  """
  def update_transaction(_root, %{id: id} = args, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.update_transaction(transaction, args) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a transaction for an id
  """
  def delete_transaction(_root, %{id: id}, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.delete_transaction(transaction) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end
end
