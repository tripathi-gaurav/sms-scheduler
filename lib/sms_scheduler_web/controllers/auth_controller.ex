defmodule SmsSchedulerWeb.AuthController do
  use SmsSchedulerWeb, :controller
  alias SmsScheduler.Users
  alias SmsScheduler.Auth

  def authenticate(conn, _params) do
    redirect conn, external: Auth.authorize_url!(scope: "user:email, repo")
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: "/")
  end

  def callback(conn, %{"code" => code}) do
    #TODO: remove the ridiculous IO side effects
    client = Auth.get_token!(code: code)
    %{body: user} = OAuth2.Client.get!(client, "/user")
    user_email = hd( Jason.decode!( OAuth2.Client.get!(client, "/user/emails").body ) )["email"]
    IO.puts "EMAIL: #{user_email}"

    token = client.token
    |> Map.drop([:__struct__, :__meta__])
    IO.puts "======"
    IO.puts "TOKEN"
    IO.inspect token
    IO.puts "CLIENT"
    IO.inspect client
    IO.puts "USER"
    IO.inspect user
    IO.puts "DECODE"
    IO.inspect Jason.decode!(user)
    IO.puts "======"

    Jason.decode!(user)
    {:ok, user} = Jason.decode(user)
    user = user
    |> Map.put("token", token.access_token)
    |> Map.put("email", user_email)

    IO.inspect(user)
    insert_user = SmsScheduler.Users.create_user(user)

    IO.inspect( insert_user )
    
    login_user = Users.get_user_by_email(user_email)
    conn
    |> put_flash(:info, "Logged in successfully!")
    |> put_session(:user, %{ id: login_user.id, name: login_user.name, email: login_user.email })
    |> redirect(to: Routes.user_path(conn, :index))
    #|> redirect(to: "/welcome")
  end
end
