defmodule ChatApp.V1.ChatRoomController do
  use ChatApp.Web, :controller

  alias ChatApp.ChatRoom
  alias ChatApp.Message

  def index_message(conn, %{"chat_room_id" => chat_room_id}) do
    messages = Message.otl(chat_room_id)

    render conn, ChatApp.V1.MessageView, "index.json", messages: messages
  end

  def create_message(conn, %{"content" => content, "chat_room_id" => chat_room_id}) do
    changeset = Message.changeset(%Message{}, %{content: content, chat_room_id: chat_room_id})

    case Repo.insert(changeset) do
      {:ok, message} ->
        conn
        |> render(ChatApp.V1.MessageView, "message.json", message: message)
    end
  end

  def delete_message(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)

    Repo.delete!(message)

    conn
    |> json(%{})
  end
end
