defmodule Live.WeatherTest do
  use ExUnit.Case

  import Mock

  alias Live.Weather

  test "weather report gets called from correct country" do
    weather_url =
      "http://samples.openweathermap.org/data/2.5/weather?q=london&appid=b6907d289e10d714a6e88b30761fae22"

      IO.inspect(HTTPoison.get(Weather.build_url("london")))
    with_mock HTTPoison, [], get: fn _url -> "rain a lot" end do
      assert called(HTTPoison.get(weather_url))
      assert HTTPoison.get(weather_url) === "rain a lot"
    end
  end

  test "greets the world" do
    json_response = %{
            "coord": %{
              "lon": -0.13,
              "lat": 51.51
            },
            "weather": [
              %{
                "id": 300,
                "main": "Drizzle",
                "description": "rain a lot",
                "icon": "09d"
              }
            ],
            "base": "stations",
            "main": %{
              "temp": 280.32,
              "pressure": 1012,
              "humidity": 81,
              "temp_min": 279.15,
              "temp_max": 281.15
            },
            "visibility": 10000,
            "wind": %{
              "speed": 4.1,
              "deg": 80
            },
            "clouds": %{
              "all": 90
            },
            "dt": 1485789600,
            "sys": %{
              "type": 1,
              "id": 5091,
              "message": 0.0103,
              "country": "GB",
              "sunrise": 1485762037,
              "sunset": 1485794875
            },
            "id": 2643743,
            "name": "Paris",
            "cod": 200
          } |> Poison.encode!

    with_mock HTTPoison, get!: fn _url -> %{body: json_response} end do
      assert Live.Weather.call("Paris") == "rain a lot"
    end
  end

  defp mocks(location) do
   [
      %{HTTPoison, [get: fn _url -> json_response end]},
    ]
  end
end

