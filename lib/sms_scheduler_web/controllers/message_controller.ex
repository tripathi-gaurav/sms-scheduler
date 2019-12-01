defmodule SmsSchedulerWeb.MessageController do
    use SmsSchedulerWeb, :controller
    alias SmsScheduler.Messages
    alias SmsScheduler.Users

    plug SmsSchedulerWeb.Plugs.VerifyUserSession when action in [:new, :create, :index, :show]

    def index(conn, _params) do
        messages = Messages.list_messages()
        render conn, "index.html", messages: messages
    end

    def new(conn, _params) do
        login_user = get_session(conn, :user)
        user = Users.get_user(login_user.id)
        message = Messages.new_message()
        render(conn, "new.html", message: message, user: user)
    end

    def create(conn, %{"message" => message_params}) do
        with user <- get_session(conn, :user),
           message_params <- Map.put(message_params, "user_id", user.id),
           {:ok, message} <- Messages.create_message(message_params)
        do
           conn
           |> put_flash(:info, "Message Send Successfully!")
           |> redirect(to: Routes.message_path(conn, :show, message))
        else
           {:error, message} ->
           conn
           |> put_flash(:error, "Error creating message!")
           |> redirect(to: Routes.message_path(conn, :new, message: message))
        end
    end

    def show(conn, params) do
        with message <- Messages.get_message(params["id"]) do
            render(conn, "show.html", message: message)
        end
    end

end