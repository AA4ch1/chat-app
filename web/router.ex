defmodule ChatApp.Router do
  use ChatApp.Web, :router

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

  scope "/", ChatApp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/chat_rooms", ChatRoomController do
      post "/message", ChatRoomController, :post_message, as: :post_message
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatApp do
  #   pipe_through :api
  # end
end
