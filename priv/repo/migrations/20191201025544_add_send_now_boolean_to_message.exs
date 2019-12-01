defmodule SmsScheduler.Repo.Migrations.AddSendNowBooleanToMessage do
  use Ecto.Migration

  def change do
    alter table("messages") do
      add :send_now, :boolean
    end
  end
end
