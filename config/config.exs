# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :dg_demo, DgDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UOhLb3PpZLT0GvgYhk5H19HMNmef+7RN7W/88CtsC+iVuLv26lFG6OPJmRnPpBKj",
  render_errors: [view: DgDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DgDemo.PubSub,
  live_view: [signing_salt: "nsMNbgXT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
