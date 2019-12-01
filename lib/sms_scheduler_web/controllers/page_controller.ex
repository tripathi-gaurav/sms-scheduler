defmodule SmsSchedulerWeb.PageController do
  use SmsSchedulerWeb, :controller
  alias SmsScheduler.Users

  def new(conn, _params) do
    login_user = get_session(conn, :user)
    user = Users.new_user()
    if(login_user == nil) do
        render(conn, "new.html", user: user, current_user: nil)
    else
      current_user = Users.get_user(login_user.id)
      render(conn, "new.html", user: user, current_user: current_user)
    end
  end

  def index(conn, _params) do
    render(conn, "index.html")  
  end
end
