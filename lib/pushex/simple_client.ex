defmodule Pushex.SimpleClient do
  @moduledoc false

  def app_key do
    System.get_env("PUSHER_APP_KEY")
  end

  def opts do
    %{
      cluster: System.get_env("PUSHER_CLUSTER"),
      encrypted: true,
      secret: System.get_env("PUSHER_SECRET")
    }
  end

  use Pushex

  def start_link(app_key, app_options, options \\ []) do
    Pushex.start_link(app_key, app_options, __MODULE__, options)
  end

  def handle_event({:ok, "public-channel", "first-event"}, frame) do
    # Process frame here
    {:ok, frame}
  end

  def handle_event({:ok, "private-channel", "second-event"}, frame) do
    # Process frame here
    {:ok, frame}
  end
  
  # In case when there is an error on event. We can catch error message.
  def handle_event({:error, msg}) do
    # Process error here
    {:error, msg}
  end
end

# # Config:
# app_key = Application.get_env(:simple_client, :pusher_app_key)
# secret = Application.get_env(:simple_client, :pusher_secret)
# cluster = Application.get_env(:simple_client, :pusher_cluster)

# options = %{cluster: cluster, encrypted: true, secret: secret}

# # Initialization:
# {:ok, pid} = SimpleClient.start_link(app_key, options)

# # Subscription to a channel:
# SimpleClient.subscribe(pid, "my-channel")

# # Private channels are also supported:
# # Please note, secret has to be provided and client events needs to be enabled
# # in Pusher app settings.
# SimpleClient.subscribe(pid, "private-channel")

# # Triggers can be performed only on private channels:
# SimpleClient.trigger(pid, "private-channel", "first-event", %{name: "Tomas Koutsky"})

# # When "first-event" callback is being triggered:
# # %Pushex.Data.Frame{
# #   channel: "private-test",
# #   data: "{\r\n  \"name\": \"John\",\r\n  \"message\": \"Hello\"\r\n}",
# #   event: "first-event"
# # }
