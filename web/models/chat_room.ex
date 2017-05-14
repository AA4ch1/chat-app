defmodule ChatApp.ChatRoom do
  use ChatApp.Web, :model

  schema "chat_rooms" do
    field :name, :string

    has_many :messages, ChatApp.Message
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
