defmodule SmsScheduler.Messages.Message do
    use Ecto.Schema
    import Ecto.Changeset
    alias SmsScheduler.Messages.Message
    alias SmsScheduler.Users.User

    schema "messages" do
        field :from, :string, size: 10
        field :body, :string
     
        belongs_to :user, User
     
        timestamps()
      end
     
      def changeset(%Message{}=message, attrs) do
        message
        |> cast(attrs, [:from, :body, :user_id])
        |> validate_required([:from, :body, :user_id])
      end
end