defmodule ChatApp.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string
      add :chat_room_id, references(:chat_rooms, on_delete: :nothing)

      timestamps()
    end
    create index(:messages, [:chat_room_id])

  end
end
