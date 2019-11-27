defmodule SmsScheduler.Repo.Migrations.AddUserIdInMessagesTable do
  use Ecto.Migration

  def change do
    alter table("messages") do
      add :user_id, references(:users)
    end

  end
end
