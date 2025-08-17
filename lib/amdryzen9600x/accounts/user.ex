defmodule Amdryzen9600x.Accounts.User do
  use Ecto.Schema

  @primary_key {:user_id, :id, autogenerate: false}
  @derive {Jason.Encoder, only: [:user_id, :email, :first_name, :surname,
                            :birthday, :registered_at, :is_active, :last_logged_in]}
  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password_plain, :string  # только на дев
    field :first_name, :string
    field :surname, :string
    field :birthday, :date
    field :registered_at, :naive_datetime
    field :is_active, :boolean
    field :last_logged_in, :naive_datetime
  end
end
