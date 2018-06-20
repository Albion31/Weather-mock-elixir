defmodule WorldCupData.MixProject do
  use Mix.Project

  def project do
    [
      app: :world_cup_data,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: WorldCupData],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:poison, "~> 3.1"}
    ]
  end
end
