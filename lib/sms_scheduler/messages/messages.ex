defmodule SmsScheduler.Messages do
    import Ecto.Query, warn: false
    alias SmsScheduler.Repo
    alias SmsScheduler.Users.User
    alias SmsScheduler.Messages.Message

    def list_messages do
        Repo.all(Message) |> Repo.preload(:user)
    end

    def recent_messages(nn) do
        Repo.all from mm in Message,
          order_by: [desc: mm.inserted_at],
          preload: [:user],
          limit: ^nn
    end

    def get_message(id) do
        Repo.one! from m in Message,
          where: m.id == ^id,
          preload: [:user]
    end

    def create_message(attrs \\ %{}) do
        %Message{}
        |> Message.changeset(attrs)
        |> Repo.insert()
    end

    def delete_message(%Message{} = message) do
        Repo.delete(message)
    end

    def new_message do
        Message.changeset(%Message{}, %{})
    end
    
end