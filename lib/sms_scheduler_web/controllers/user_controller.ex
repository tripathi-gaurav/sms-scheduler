defmodule SmsSchedulerWeb.UserController do
    use SmsSchedulerWeb, :controller
    alias SmsScheduler.Users
   
    def new(conn, _params) do
        user = Users.new_user()
        render conn "new.html", user: user
    end

    def create(conn, %{"user" => user_params}) do
        with {:ok, user} <- Users.create_user(user_params) do
            conn
            |> put_flash(:info, "User created!")
            |> redirect(to: user_path(conn, :show, user))
          else
            {:error, user} ->
              conn
              |> put_flash(:error, "Failed to create user!")
              |> render("new.html", user: user)
          end
    end

    def index(conn, _params) do
      users = Users.list_users()
      render conn, "index.html", users: users
    end

    def show(conn, _params) do
        with user <- Users.get_user(id), do
             render(conn, "show.html", user: user)
        end
    end
   end