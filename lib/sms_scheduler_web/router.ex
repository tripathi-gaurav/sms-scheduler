defmodule SmsSchedulerWeb.Router do
  use SmsSchedulerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug SmsSchedulerWeb.Plugs.VerifyUserSession
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SmsSchedulerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/combinedlogin", PageController, :new
    get "/users/new", UserController, :new
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
    get "/users", UserController, :index
    get "/users/:id/edit", UserController, :edit
    put "/users/:id", UserController, :update

    get "/messages/new", MessageController, :new
    get "/messages/:id", MessageController, :show
    post "/messages", MessageController, :create

    resources "/sessions", SessionController, only: [:create]

    get "/login", SessionController, :new
    get "/logout", SessionController, :delete

    # Oauth2 Authentication
    # obtained from class notes
    get "/auth", AuthController, :authenticate
    delete "/auth", AuthController, :delete
    get "/auth/callback", AuthController, :callback
  
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmsSchedulerWeb do
  #   pipe_through :api
  # end

  
end
