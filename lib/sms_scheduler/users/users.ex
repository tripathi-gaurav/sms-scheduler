defmodule SmsScheduler.Users do
    import Ecto.Query, warn: false
    alias SmsScheduler.Repo
    alias SmsScheduler.Users.User
    alias SmsScheduler.Messages.Message

    def new_user do
        User.changeset(%User{}, %{})
    end

    def list_users do
        Repo.all(User) |> Repo.preload(:messages)
    end


    def create_users(user_attrs) do
        Repo.transaction(fn ->
          with {:ok, user} <- create_user(user_attrs)
          do
            user
          else
            _ -> Repo.rollback("Failed to create user")
          end
        end)
    end

    def create_user(attrs) do
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end

    def get_user(id), do: Repo.get(User, id)

    def get_user_by_email(email) do
        Repo.get_by(User, email: email)
    end

end