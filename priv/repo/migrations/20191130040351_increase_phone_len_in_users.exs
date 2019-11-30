defmodule SmsScheduler.Repo.Migrations.IncreasePhoneLenInUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      modify :phone, :string, size: 12, null: true
    end
  end
end
