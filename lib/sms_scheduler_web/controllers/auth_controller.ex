defmodule SmsSchedulerWeb.AuthController do
  use SmsSchedulerWeb, :controller

  alias SmsScheduler.Auth

  def authenticate(conn, _params) do
    redirect conn, external: Auth.authorize_url!(scope: "user, repo")
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: "/")
  end

  def callback(conn, %{"code" => code}) do
    client = Auth.get_token!(code: code)
    %{body: user} = OAuth2.Client.get!(client, "/user")

    token = client.token
    |> Map.drop([:__struct__, :__meta__])

    {:ok, user} = Jason.decode!(user)
    |> Map.put("token", token)
    |> SmsScheduler.Users.create_user()

    IO.inspect(user)

    conn
    |> put_session(:user_id, user.id)
    |> redirect(to: "/welcome")
  end
end
