defmodule Mnesiageoip.Mixfile do
  use Mix.Project

  def project do
    [ app: :mnesiageoip,
      version: "0.0.1",
      elixir: "~> 0.10.3",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Mnesiageoip, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [ 
      { :amnesia,              [github: "meh/amnesia",                    ]},
      {:elixir_csv,"0.1.1",[github: "baldmountain/elixir_csv"]}
    ]
  end
end
