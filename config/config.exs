# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :confer,
  ecto_repos: [Confer.Repo]

# Configures the endpoint
config :confer, Confer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iSFyDU3LoIfp8H7YQVexXpSFZTOYuGSXC6OWMlr0u2em1jLENz+ya3TD/gEZzNyj",
  render_errors: [view: Confer.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Confer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Confer.User,
  repo: Confer.Repo,
  module: Confer,
  logged_out_url: "/",
  email_from: {"工程热物理", "admin@thermodynamics.cn"},
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :confirmable, :registerable]

config :coherence, Confer.Coherence.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "smtp.exmail.qq.com",
  username: "admin@thermophysics.cn",
  password: "Thermo.123",
  tls: :always,
  auth: :always,
  ssl: true # default 25, ssl 465
  # dkim: [
  #   s: "default", d: "domain.com",
  #   private_key: {:pem_plain, File.read!("priv/keys/domain.private")}
  # ]

# %% End Coherence Configuration %%

# Gettext i18n
config :confer, Confer.Gettext, default_locale: "zh"

config :xain, :after_callback, {Phoenix.HTML, :raw}

# ExAdmin
config :ex_admin,
  repo: Confer.Repo,
  module: Confer,
  head_template: {Confer.AdminView, "admin_layout.html"},
  modules: [
    Confer.ExAdmin.Dashboard,
    Confer.ExAdmin.Post,
    Confer.ExAdmin.User,
    Confer.ExAdmin.Role,
    Confer.ExAdmin.Topic,
    Confer.ExAdmin.Paper,
    Confer.ExAdmin.Page,
    Confer.ExAdmin.Status,
    Confer.ExAdmin.Review,
    Confer.ExAdmin.Info
  ]

# ExFile
config :exfile, Exfile,
  secret: "x1fh/CivQeGV6npnqfJ4Ht2LGh/EtgYQavyIi0L2y+8b9tZpwQ1l88qBqWqYb7PN",
  backends: %{
    "store" => {Exfile.Backend.FileSystem,
      directory: Path.expand("./uploads/store")
    },
    "cache" => {Exfile.Backend.FileSystem,
      directory: Path.expand("./uploads/cache")
    }
  }
