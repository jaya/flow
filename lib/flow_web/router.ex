defmodule FlowWeb.Router do
  use FlowWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug FlowWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FlowWeb do
    pipe_through :browser

    get "/", UserController, :login
    get "/users", UserController, :index
    get "/users/:id/edit", UserController, :edit
    put "/users/:id", UserController, :update
    patch "/users/:id", UserController, :update

    resources "/jobs", JobController
    resources "/clients", ClientController
    resources "/status", StatusController
    resources "/technologies", TechnologyController
    resources "/candidates", CandidateController

    delete "/comment/:id", CommentController, :delete
  end

  scope "/auth", FlowWeb do
    pipe_through :browser

    get "/", UserController, :login
    get "/signout", UserController, :signout
    get "/:provider", UserController, :request
    get "/:provider/callback", UserController, :callback
  end


  # Other scopes may use custom stacks.
  # scope "/api", FlowWeb do
  #   pipe_through :api
  # end
end
