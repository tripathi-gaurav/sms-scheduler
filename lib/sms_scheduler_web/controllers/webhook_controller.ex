defmodule SmsSchedulerWeb.WebhookController do
use SmsSchedulerWeb, :controller
alias SmsScheduler.BackupAgent

def hook(conn, params) do
  case params["event"] do
    "addition" -> add(conn, params)
    "subtraction" -> subtract(conn, params)
    "multiplication" -> multiply(conn, params)
    "divison" -> divide(conn, params)
    "recv_sms" -> recv_sms(conn, params)
  end
end

    def recv_sms(conn, params) do
      IO.inspect params
      conn_of_user = BackupAgent.get( "gaurav@tripathi.org" )
      conn_of_user |> put_flash(:info, "New message received!") |> redirect(to: Routes.users_path(conn_of_user, :index))
    end

    def add(conn, _params), do: send_resp(conn, 200, "Hello, world!")
    def subtract(conn, params), do: IO.puts "Hello"
    def multiply(conn, params), do: IO.puts "Hello"
    def divide(conn, params), do: IO.puts "hello div"

end

