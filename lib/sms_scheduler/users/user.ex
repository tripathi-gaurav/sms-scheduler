defmodule SmsScheduler.Users.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias SmsScheduler.Users.User
    alias SmsScheduler.Messages.Message

    schema "users" do
        field :name, :string
        field :email, :string
        field :phone, :string, size: 10
        field :password_hash, :string
        field :token, :string

        field :password, :string, virtual: true
        field :password_confirmation, :string, virtual: true

        has_many :messages, Message
         
        timestamps()
    end

    def changeset(%User{}=user, attrs) do
        user
        |> cast(attrs, [:name, :email, :phone, :password, :password_confirmation, :token])
        |> validate_confirmation(:password, message: "does not match password!")
        |> encrypt_password()
        |> validate_required([:name, :email])
        |> validate_required_inclusion([:token, :password_hash])
        #|> validate_required([:name, :email, :phone, :password_hash])
    end

    def encrypt_password(changeset) do
        with password when not is_nil(password) <- get_change(changeset, :password) do
                put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
        else
                _ -> changeset
        end     
    end


    # Code obtained from stackoverflow: 
    # https://stackoverflow.com/questions/42212425/conditional-validation-in-ecto-for-or-1-of-2-fields-is-required
    def validate_required_inclusion(changeset, fields) do
        if Enum.any?(fields, &present?(changeset, &1)) do
            changeset
        else
            # Add the error to the first field only since Ecto requires a field name for each error.
            add_error(changeset, hd(fields), "One of these fields must be present: #{inspect fields}")
        end
    end

    def present?(changeset, field) do
        value = get_field(changeset, field)
        value && value != ""
    end
end