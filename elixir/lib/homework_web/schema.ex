defmodule HomeworkWeb.Schema do
  @moduledoc """
  Defines the graphql schema for this project.
  """
  use Absinthe.Schema

  alias HomeworkWeb.Resolvers.MerchantsResolver
  alias HomeworkWeb.Resolvers.TransactionsResolver
  alias HomeworkWeb.Resolvers.UsersResolver
  import_types(HomeworkWeb.Schemas.Types)

  query do
    @desc "Get a transaction by id"
    field(:transaction, :transaction) do
      arg :id, non_null(:id)
      resolve(&TransactionsResolver.transaction/3)
    end

    @desc "Get all Transactions"
    field(:transactions, list_of(:transaction)) do
      arg(:days, :integer)
      arg(:min, :integer)
      arg(:max, :integer)
      arg(:limit, :integer)
      arg(:skip, :integer)
      resolve(&TransactionsResolver.transactions/3)
    end

    @desc "Get all Users"
    field(:users, list_of(:user)) do
      arg(:first_name, :string)
      arg(:last_name, :string)
      arg(:limit, :integer)
      arg(:skip, :integer)
      resolve(&UsersResolver.users/3)
    end

    @desc "Get a user by id"
    field(:user, :user) do
      arg :id, non_null(:id)
      resolve(&UsersResolver.user/3)
    end

    @desc "Get a merchant by id"
    field(:merchant, :merchant) do
      arg :id, non_null(:id)
      resolve(&MerchantsResolver.merchant/3)
    end

    @desc "Get all Merchants"
    field(:merchants, list_of(:merchant)) do
      arg(:name, :string)
      arg(:limit, :integer)
      arg(:skip, :integer)
      resolve(&MerchantsResolver.merchants/3)
    end
  end

  mutation do
    import_fields(:transaction_mutations)
    import_fields(:user_mutations)
    import_fields(:merchant_mutations)
  end
end
