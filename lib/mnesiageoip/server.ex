defmodule Mnesiageoip.Server do
  use GenServer.Behaviour
 

 def start_link() do
    :gen_server.start_link(__MODULE__, [], [])
  end

  def handle_call({:find_city, IP}, from, state) do
    {:reply, :ok, state}
  end

  def handle_call({:find_country, IP}, from, state) do
    {:reply, :ok, state}
  end

  def handle_call({:import, FileType, FilePath}, from, state) do
    import_geoip_file({FileType, FilePath})
    {:reply, :ok, state}
  end

  def handle_call(request, from, state) do
    super(request, from, state)
  end

  def handle_cast(_request, _from, state) do
    {:reply, :ok, state}
  end

  defp format_ip({A,B,C,D}) do
    ( 16777216 * A ) + ( 65536 * B ) + ( 256 * C ) + D
  end

  defp import_geoip_file({:countries, FilePath}) do
    {:ok, data} = :file.open("priv/data/GeoIPCountryWhois.csv", [:read])

    insert_countries_to_mnesia = fn(Row, State) ->
      IO.inspect Row
      Counter + 1
    end

   
  end



  defp import_geoip_file({:city_blocks, FilePath}) do

  end

  defp import_geoip_file({:city_locations, FilePath}) do

  end

  defp import(_) do
    :error
  end


end