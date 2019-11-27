defmodule SmsSchedulerWeb.Router do
  use SmsSchedulerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SmsSchedulerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/users/new", UserController, :new
    get "/users/:id", UserController, :show
    post "/users", UserController, :create

    resources "/sessions", SessionController, only: [:create]

    get "/login", SessionController, :new
    get "/logout", SessionController, :delete
  
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmsSchedulerWeb do
  #   pipe_through :api
  # end
end
