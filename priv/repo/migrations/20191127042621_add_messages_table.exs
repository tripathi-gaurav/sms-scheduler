defmodule SmsScheduler.Repo.Migrations.AddMessagesTable do
  use Ecto.Migration

  def change do
    create table("messages") do
      add :from, :string, size: 10, null: false
      add :body, :text, null: false
      add :user_id, references(:users)

      timestamps()
    end

  end
end
