defmodule SmsSchedulerWeb.UserController do
    use SmsSchedulerWeb, :controller
    alias SmsScheduler.Users
    
   
    def new(conn, _params) do
        user = Users.new_user()
        render(conn, "new.html", user: user)
    end

    def create(conn, %{"user" => user_params}) do
       available_phone_numbers = ExTwilio.AvailablePhoneNumber.stream(
       iso_country_code: "US",
       type: "Local")
       IO.inspect available_phone_numbers
       IO.inspect available_phone_numbers |> Enum.take(1) |> List.first
       number = available_phone_numbers |> Enum.take(1) |> List.first
       IO.puts number.phone_number
       phone_number = number.phone_number
       IO.inspect user_params
       app_sid = ExTwilio.Config.account_sid()
        settings = [
          {:friendly_name, user_email},
          {:phone_number, phone_number}
        ]
        number_resp = ExTwilio.IncomingPhoneNumber.create(settings)
        IO.inspect number_resp
       user_params = Map.put(user_params, "phone", phone_number )
        with {:ok, user} <- Users.create_user(user_params) do
            conn
            |> put_flash(:info, "User created!")
            |> redirect(to: Routes.session_path(conn, :new))
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
        user = Users.get_user(params["id"])
        number_list = Users.get_unique_number_list(user)
        final_number_list = Enum.uniq(number_list)
        with user <- Users.get_user(params["id"]) do
             render(conn, "show.html", user: user, final_number_list: final_number_list)
        end
    end

    def edit(conn, %{"id" => id}) do
      user = Users.get_user(id)
      changeset = Users.change_user(user)
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  
    def update(conn, %{"id" => id, "user" => user_params}) do
      user = Users.get_user(id)
  
      case Users.update_user(user, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset)
      end
    end
   end