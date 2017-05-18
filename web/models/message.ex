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

  def otl(query) do
    from m in ^query, order_by: [asc: m.inserted_at]
  end
end
