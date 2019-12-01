defmodule SmsScheduler.Repo.Migrations.IncreasePhoneLenInMessages do
  use Ecto.Migration

  def change do
    alter table("messages") do
      modify :to, :string, size: 12, null: true
    end
  end
end
