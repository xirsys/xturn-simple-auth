defmodule Xirsys.XTurn.SimpleAuth.MixProject do
  use Mix.Project

  def project do
    [
      app: :xturn_simple_auth,
      version: "0.1.0",
      elixir: "~> 1.7",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Simple authentication module for the XTurn server.",
      source_url: "https://github.com/xirsys/xturn-simple-auth",
      homepage_url: "https://xturn.me",
      package: package(),
      docs: [
        extras: ["README.md", "LICENSE.md"],
        main: "readme"
      ]
    ]
  end

  def application do
    [mod: {Xirsys.XTurn.SimpleAuth.Supervisor, []}, applications: [:maru]]
  end

  defp deps do
    [
      {:xmedialib, "~> 0.1"},
      {:xturn_cache, "~> 0.1"},
      {:maru, "~> 0.13"},
      {:jason, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  defp package do
    %{
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Jahred Love"],
      licenses: ["Apache 2.0"],
      organization: ["Xirsys"],
      links: %{"Github" => "https://github.com/xirsys/xturn-simple-auth"}
    }
  end
end
