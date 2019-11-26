use Mix.Config

# Configure your database
config :sms_scheduler, SmsScheduler.Repo,
  username: "sms_scheduler",
  password: "ieHaw0aeshah",
  database: "sms_scheduler_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sms_scheduler, SmsSchedulerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
