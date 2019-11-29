defmodule SmsScheduler.Repo.Migrations.RemoveNotNullFromPhoneInUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      modify :phone, :string, size: 10, null: true
    end
  end
end
