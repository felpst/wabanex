defmodule WabanexWeb.Router do # This file is the starting point of our application.
  use WabanexWeb, :router

  pipeline :api do # Here it is defining a pipeline that basically says that all routes that are defined using pipe_through :api will only accept JSON
    plug :accepts, ["json"]
  end

  scope "/api", WabanexWeb do
    pipe_through :api

    get "/", IMCController, :index # Here I am creating a new get route, the IMCController will be the one treating the request and the action of this controller is :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: WabanexWeb.Telemetry
    end
  end
end
