# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sms_scheduler,
  ecto_repos: [SmsScheduler.Repo]

# Configures the endpoint
config :sms_scheduler, SmsSchedulerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2c/wWfc5zPY4S7dKt9hgjGYfaYrX36yJY53fFWaAiJqqtJASX0MLN/zLxHjO/z72",
  render_errors: [view: SmsSchedulerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SmsScheduler.PubSub, adapter: Phoenix.PubSub.PG2]
  
config :ex_twilio, account_sid: System.get_env("TWILIO_ACCOUNT_SID")
config :ex_twilio, auth_token: System.get_env("TWILIO_AUTH_TOKEN")

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
