defmodule SmsScheduler.Repo.Migrations.RenameColoumInMessageTable do
  use Ecto.Migration

  def change do
    rename table(:messages), :from, to: :to
  end
end
