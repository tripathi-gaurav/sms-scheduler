defmodule SmsScheduler.Messages.Message do
    use Ecto.Schema
    import Ecto.Changeset
    alias SmsScheduler.Messages.Message
    alias SmsScheduler.Users.User

    schema "messages" do
        field :to, :string, size: 10
        field :body, :string
        field :send_time, :naive_datetime
        field :send_now, :boolean
        belongs_to :user, User
     
        timestamps()
    end
     
    def changeset(%Message{}=message, attrs) do
        message
        |> cast(attrs, [:to, :body, :user_id, :send_now, :send_time])
        |> validate_required([:to, :body, :user_id])
    end
end