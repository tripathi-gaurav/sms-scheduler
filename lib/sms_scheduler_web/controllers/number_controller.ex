defmodule SmsSchedulerWeb.NumberController do
    use SmsSchedulerWeb, :controller
    alias SmsScheduler.Users

    def show(conn, params) do
        to = params["id"]
        login_user = get_session(conn, :user)
        user = Users.get_user(login_user.id)
        render(conn, "show.html", user: user, to: to)
    end
end