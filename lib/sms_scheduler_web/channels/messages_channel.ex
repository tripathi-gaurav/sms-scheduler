defmodule SmsSchedulerWeb.MessagesChannel do
    use SmsSchedulerWeb, :channel

  def join("messages:*", _payload, socket) do
    {:ok, socket}
  end

end