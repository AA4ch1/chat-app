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

  scope "/api", ChatApp do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/chat_rooms", ChatRoomController, except: [:new, :edit] do
        get "/messages", ChatRoomController, :index_message, as: :index_message
        post "/messages", ChatRoomController, :create_message, as: :create_message
        delete "/messages/:id", ChatRoomController, :delete_message, as: :delete_message
      end
    end
  end
end
