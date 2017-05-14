defmodule ChatApp.ChatRoomController do
  use ChatApp.Web, :controller

  alias ChatApp.ChatRoom

  def index(conn, _params) do
    chat_rooms = Repo.all(ChatRoom)
    render(conn, "index.html", chat_rooms: chat_rooms)
  end

  def new(conn, _params) do
    changeset = ChatRoom.changeset(%ChatRoom{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chat_room" => chat_room_params}) do
    changeset = ChatRoom.changeset(%ChatRoom{}, chat_room_params)

    case Repo.insert(changeset) do
      {:ok, _chat_room} ->
        conn
        |> put_flash(:info, "Chat room created successfully.")
        |> redirect(to: chat_room_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chat_room = Repo.get!(ChatRoom, id)
    render(conn, "show.html", chat_room: chat_room)
  end

  def edit(conn, %{"id" => id}) do
    chat_room = Repo.get!(ChatRoom, id)
    changeset = ChatRoom.changeset(chat_room)
    render(conn, "edit.html", chat_room: chat_room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chat_room" => chat_room_params}) do
    chat_room = Repo.get!(ChatRoom, id)
    changeset = ChatRoom.changeset(chat_room, chat_room_params)

    case Repo.update(changeset) do
      {:ok, chat_room} ->
        conn
        |> put_flash(:info, "Chat room updated successfully.")
        |> redirect(to: chat_room_path(conn, :show, chat_room))
      {:error, changeset} ->
        render(conn, "edit.html", chat_room: chat_room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chat_room = Repo.get!(ChatRoom, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chat_room)

    conn
    |> put_flash(:info, "Chat room deleted successfully.")
    |> redirect(to: chat_room_path(conn, :index))
  end
end
