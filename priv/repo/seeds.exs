# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ChatApp.Repo.insert!(%ChatApp.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule ChatApp.DatabaseSeeder do
  alias ChatApp.Repo
  alias ChatApp.Message

  def insert_message do
    Repo.insert! %Message{
      content: Faker.Lorem.paragraph(%Range{first: 1, last: 2}),
      chat_room_id: 1
    }
  end
end

(1..10)
|> Enum.each(fn _ -> ChatApp.DatabaseSeeder.insert_message end)
