defmodule ChatApp.Message do
  use ChatApp.Web, :model

  import Ecto.Query, only: [from: 2]

  alias ChatApp.Repo

  schema "messages" do
    field :content, :string
    belongs_to :chat_room, ChatApp.ChatRoom

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :chat_room_id])
    |> validate_required([:content, :chat_room_id])
  end

  def otl(chat_room_id) do
    query = from m in ChatApp.Message, where: m.chat_room_id == ^chat_room_id,
                                       order_by: [asc: m.inserted_at]

    Repo.all(query)
  end
end
