defmodule ChatApp.V1.MessageView do
  use ChatApp.Web, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, ChatApp.V1.MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      content: message.content,
      created_at: message.inserted_at}
  end
end
