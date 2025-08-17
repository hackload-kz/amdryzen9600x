defmodule Amdryzen9600x.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:users, primary_key: false) do
      add :user_id, :integer, primary_key: true
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :password_plain, :string
      add :first_name, :string, null: false
      add :surname, :string, null: false
      add :birthday, :date
      add :registered_at, :naive_datetime, null: false
      add :is_active, :boolean, null: false, default: true
      add :last_logged_in, :naive_datetime, null: false
    end

    create_if_not_exists unique_index(:users, [:email])
  end
end
