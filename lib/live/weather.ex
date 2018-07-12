defmodule Live.Weather do
  def call(location) do
    location
    |> build_url
    |> HTTPoison.get!()
    |> parse_response()
  end

  def build_url(location) do
    "http://samples.openweathermap.org/data/2.5/weather?q=" <>
      location <> "&appid=b6907d289e10d714a6e88b30761fae22"
  end

  defp parse_response(response) do
    %{"weather" => [weather | _other]} =
      response.body
      |> Poison.decode!()

    weather["description"]
  end
end
