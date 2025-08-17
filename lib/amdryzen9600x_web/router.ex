defmodule Amdryzen9600xWeb.Router do
  use Amdryzen9600xWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {Amdryzen9600xWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/internal", Amdryzen9600xWeb do
    pipe_through :api
    get "/health", HealthController, :show
    get "/auth-check", AuthController, :check
  end

  scope "/", Amdryzen9600xWeb do
    pipe_through :browser
    get "/", PageController, :home
  end

  if Application.compile_env(:amdryzen9600x, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: Amdryzen9600xWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
