defmodule SmsScheduler.Repo.Migrations.AddSendTimeToMessages do
  use Ecto.Migration

  def change do
    alter table("messages") do
      add :send_time, :naive_datetime
    end
  end
end
