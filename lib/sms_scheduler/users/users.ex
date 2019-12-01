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

    def create_user(attrs) do
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end

    def get_user(id) do
      if(id == -1) do
        nil
      else
        Repo.one! from u in User,
          where: u.id == ^id,
          preload: [:messages]
      end
    end

    def get_user_by_email(email) do
      Repo.one! from u in User,
          where: u.email == ^email,
          preload: [:messages]
    end

    def update_user(%User{} = user, attrs) do
      user
      |> User.changeset(attrs)
      |> Repo.update()
    end

    def change_user(%User{} = user) do
      User.changeset(user, %{})
    end

    def get_unique_number_list(user) do
      number_list = []
      messages = user.messages
      final_list = create_number_list(messages, number_list)
      final_list
    end

    def create_number_list(messages, number_list) when length(messages) != 0 do
      number_list = [hd(messages).to] ++ number_list
      create_number_list(tl(messages), number_list)
    end

    def create_number_list(messages, number_list) when length(messages) == 0 do
      number_list
    end
end