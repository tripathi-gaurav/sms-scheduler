defmodule SmsSchedulerWeb.PageController do
  use SmsSchedulerWeb, :controller
  alias SmsScheduler.Users

  def new(conn, _params) do
    user = Users.new_user()
    render(conn, "new.html", user: user)
  end

  def index(conn, _params) do
    render(conn, "index.html")  
  end
end
