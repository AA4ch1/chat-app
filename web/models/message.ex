defmodule ChatApp.Message do
  use ChatApp.Web, :model

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
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
