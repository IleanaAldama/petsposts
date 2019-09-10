defmodule PetspostsWeb.Router do
  use PetspostsWeb, :router
  alias Phoenix.Controller

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :api_auth
  end

  scope "/api", PetspostsWeb do
    pipe_through :api

    resources "/posts", PostApiController, only: [:create, :index, :show]
  end

  scope "/", PetspostsWeb do
    pipe_through :browser

    resources "/", PostController, only: [:create, :index, :show]
  end

  defp current_user(conn, _ ) do
    assign(conn, :current_user, Petsposts.Accounts.current_user)
  end

  defp api_auth(conn, _) do
    token = Application.get_env(:petsposts, :api_auth_token)
    case  get_req_header(conn, "auth-token") do
      [^token] ->
        conn

      _ ->
        conn
        |> put_status(401)
        |> Controller.render(PetspostsWeb.ErrorView, "401.json")
        |> halt()
    end
  end

end
