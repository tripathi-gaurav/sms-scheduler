defmodule SmsScheduler.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, null: false
      add :email, :string, null: false
      add :phone, :string, size: 10, null: false
      add :password_hash, :string
      add :token, :string
         
      timestamps()
    end
  end
end
