defmodule SmsScheduler.Repo do
  use Ecto.Repo,
    otp_app: :sms_scheduler,
    adapter: Ecto.Adapters.Postgres
end
