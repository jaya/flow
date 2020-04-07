defmodule FlowWeb.Router do
  use FlowWeb, :router

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

  scope "/", FlowWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/jobs", JobController
    resources "/clients", ClientController
    resources "/status", StatusController
    resources "/technologies", TechnologyController
    resources "/candidates", CandidateController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FlowWeb do
  #   pipe_through :api
  # end
end
