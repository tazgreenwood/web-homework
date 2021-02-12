# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Homework.Repo.insert!(%Homework.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Delete All Data
Homework.Repo.delete_all Homework.Transactions.Transaction
Homework.Repo.delete_all Homework.Users.User
Homework.Repo.delete_all Homework.Merchants.Merchant

defmodule Homework.DatabaseSeeder do
  @amount_list [123,432,626,21,6114,1,2344,654,3,234,1]
  @transaction_description_list ["Purchased a laptop", "Purchased 5 reams of paper", "Purchased a puppy", "Purchased a new car", "Purchased food"]
  @merchant_name_list ["Dunder Mifflin, Inc.", "Vance Refridgeration", "Bob's Tools", "Puppy Barn", "Better Buy", "Mickey D's"]
  @merchant_description_list ["A Paper Company", "An Electronics Company", "A Puppy Company", "A Car Company", "A Food Company"]
  @user_first_name_list ["Dwight", "Michael", "Pam", "Jim", "Kevin", "Holly", "Stanley", "Oscar"]
  @user_last_name_list ["Schrute", "Scott", "Beesly", "Halpert", "Malone", "Flax", "Hudson", "Martinez"]
  @user_dob_list ["05/04/1990", "09/01/1992", "12/25/2000", "10/31/1980", "02/29/1958", "04/14/1986"]

  def insert_debit_transaction do
    Homework.Repo.insert!(%Homework.Transactions.Transaction{
      amount: (Enum.random(@amount_list)),
      debit: true,
      description: (Enum.random(@transaction_description_list)),
      merchant: %Homework.Merchants.Merchant{name: (Enum.random(@merchant_name_list)), description: (Enum.random(@merchant_description_list))},
      user: %Homework.Users.User{first_name: (Enum.random(@user_first_name_list)), last_name: (Enum.random(@user_last_name_list)), dob: (Enum.random(@user_dob_list))}
    })
  end

  def insert_credit_transaction do
    Homework.Repo.insert!(%Homework.Transactions.Transaction{
      amount: (Enum.random(@amount_list)),
      credit: true,
      description: (Enum.random(@transaction_description_list)),
      merchant: %Homework.Merchants.Merchant{name: (Enum.random(@merchant_name_list)), description: (Enum.random(@merchant_description_list))},
      user: %Homework.Users.User{first_name: (Enum.random(@user_first_name_list)), last_name: (Enum.random(@user_last_name_list)), dob: (Enum.random(@user_dob_list))}
    })
  end

end

(1..10) |> Enum.each(fn _ -> Homework.DatabaseSeeder.insert_debit_transaction end)
(1..10) |> Enum.each(fn _ -> Homework.DatabaseSeeder.insert_credit_transaction end)
