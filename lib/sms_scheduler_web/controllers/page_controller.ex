defmodule SmsSchedulerWeb.PageController do
  use SmsSchedulerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
