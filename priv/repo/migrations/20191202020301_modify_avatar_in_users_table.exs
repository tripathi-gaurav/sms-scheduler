defmodule SmsScheduler.Repo.Migrations.ModifyAvatarInUsersTable do
  use Ecto.Migration
  alias SmsScheduler.Users

  def change do
    alter table(:users) do
      modify :avatar_url, :string, default: "/images/profile.jpg"
    end
  end
end
