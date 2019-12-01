defmodule SmsSchedulerWeb.SessionController do
    use SmsSchedulerWeb, :controller
    alias SmsScheduler.Users

    def new(conn, _) do
        render(conn, "new.html")
      end
    
      def delete(conn, _) do
        conn
        |> delete_session(:user)
        |> put_flash(:info, "Logged out successfully!")
        |> redirect(to: Routes.page_path(conn, :index))
      end
    
      def create(conn, %{"email" => email, "password" => password}) do
        if(email == "" && password == "") do
          conn
          |> put_flash(:error, "Invalid username/password!")
          |> render("new.html")
        end
        with user <- Users.get_user_by_email(email),
             {:ok, login_user} <- login(user, password)
        do
          conn
          |> put_flash(:info, "Logged in successfully!")
          |> put_session(:user, %{ id: login_user.id, name: login_user.name, email: login_user.email })
          |> redirect(to: Routes.user_path(conn, :index))
        else
          {:error, _} ->
            conn
            |> put_flash(:error, "Invalid username/password!")
            |> render("new.html")
        end
      end

      defp login(user, password) do
        Comeonin.Bcrypt.check_pass(user, password)
      end

end
