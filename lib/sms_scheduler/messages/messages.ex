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
        #TODO: from_number should be available here without db query

        message = %Message{}
        |> Message.changeset(attrs)


        IO.inspect message.changes
        m = message.changes

        IO.puts ExTwilio.Config.account_sid()
        IO.puts ExTwilio.Config.api_domain()
        IO.puts ExTwilio.Config.api_version()
        IO.puts ExTwilio.Config.auth_token()
        t = ExTwilio.Message.create(to: m.to, from: "+18573204133", body: m.body)
        IO.inspect t

        message
        |> Repo.insert()
    end

    def delete_message(%Message{} = message) do
        Repo.delete(message)
    end

    def new_message do
        Message.changeset(%Message{}, %{})
    end
    
end