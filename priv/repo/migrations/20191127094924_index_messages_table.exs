defmodule SmsScheduler.Repo.Migrations.IndexMessagesTable do
  use Ecto.Migration


  def change do
    create index(:messages, [:user_id])
  end
end
