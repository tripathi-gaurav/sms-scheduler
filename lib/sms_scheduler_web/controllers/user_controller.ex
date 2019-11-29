defmodule SmsSchedulerWeb.UserController do
    use SmsSchedulerWeb, :controller
    alias SmsScheduler.Users
    
   
    def new(conn, _params) do
        user = Users.new_user()
        render(conn, "new.html", user: user)
    end

    def create(conn, %{"user" => user_params}) do
        with {:ok, user} <- Users.create_user(user_params) do
            conn
            |> put_flash(:info, "User created!")
            |> redirect(to: Routes.user_path(conn, :show, user))
          else
            {:error, user} ->
              conn
              |> put_flash(:error, "Failed to create user!")
              |> render("new.html", user: user)
          end
    end

    def index(conn, params) do
      login_user = get_session(conn, :user)
      user = Users.get_user(login_user.id)
      render conn, "index.html", user: user
    end

    def show(conn, params) do
        with user <- Users.get_user(params["id"]) do
             render(conn, "show.html", user: user)
        end
    end
   end