defmodule ChatApp.ChatRoomTest do
  use ChatApp.ModelCase

  alias ChatApp.ChatRoom

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ChatRoom.changeset(%ChatRoom{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ChatRoom.changeset(%ChatRoom{}, @invalid_attrs)
    refute changeset.valid?
  end
end
