defmodule SmsScheduler.Auth do
  use OAuth2.Strategy
  alias OAuth2.Strategy.AuthCode

  @config [
    strategy: __MODULE__,
    site: "https://api.github.com",
    authorize_url: "https://github.com/login/oauth/authorize",
    token_url: "https://github.com/login/oauth/access_token",
  ]

  def new do
    Application.get_env(:sms_scheduler, __MODULE__)
    |> Keyword.merge(@config)
    |> OAuth2.Client.new()
  end

  def new(token) do
    %{new() | token: OAuth2.AccessToken.new(token) }
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(new(), params, headers)
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(new(), params)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
