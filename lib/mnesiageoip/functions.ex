defmodule Mnesiageoip.Functions do
  use Amnesia
  use Mnesiageoip.Database
  require Exquisite

  def import_countries(filepath) do
    countries = File.stream!(filepath)
    Enum.each(countries, fn (x) -> spawn(__MODULE__, :write_countries, [List.flatten(CSV.parse(x))]) end)
  end

  def write_countries(x) do
    [_,_,ipstart_temp,ipend_temp,code,country] = x    
    {ipstart,_} = String.to_integer(ipstart_temp)
    {ipend,_} = String.to_integer(ipend_temp)
    c = Country[ipstart: ipstart, ipend: ipend, countrycode: code, country: country]
    c.write!
  end

  def import_city_blocks(filepath) do
    cityblocks = File.stream!(filepath)
    Enum.each(cityblocks, fn (x) -> spawn(__MODULE__, :write_city_blocks, [List.flatten(CSV.parse(x))]) end)
  end

  def write_city_blocks(x) do
    [ipstart_temp,ipend_temp,cityid_temp] = x    
    {ipstart,_} = String.to_integer(ipstart_temp)
    {ipend,_} = String.to_integer(ipend_temp)
    {cityid,_} = String.to_integer(cityid_temp)
    c = CityBlock[ipstart: ipstart, ipend: ipend, cityid: cityid]
    c.write!
  end

  def import_city_locations(filepath) do
    city_locations = File.stream!(filepath)
    Enum.each(city_locations, fn (x) -> spawn(__MODULE__, :write_city_locations, [List.flatten(CSV.parse(x))]) end)
  end

  def write_city_locations(x) do
    [id_temp,country,state,city,postalcode,lat,long,metrocode, areacode] = x    
    {id,_} = String.to_integer(id_temp)
    c = CityLocation[id: id, country: country, state: state, city: city, postalcode: postalcode, lat: lat, long: long, metrocode: metrocode, areacode: areacode]
    c.write!
  end

  def query_country(a) do
    formattedip = format_ip(a)
    query = Exquisite.match Country, where: ipstart <= formattedip and ipend >= formattedip
    {_,result,_} = Amnesia.transaction do
      Country.select query
    end
    [Mnesiageoip.Database.Country[ipstart: _, ipend: _, countrycode: result_countrycode, country: result_country]] = result
    {result_country, result_countrycode}
  end

  def query_city(a) do
    formattedip = format_ip(a)
    query = Exquisite.match CityBlock, where: ipstart <= formattedip and ipend >= formattedip
    {_,result,_} = Amnesia.transaction do
      CityBlock.select query
    end
    [Mnesiageoip.Database.CityBlock[ipstart: _, ipend: _, cityid: result_city_id ]] = result
    CityLocation.read!(result_city_id)
  end

  defp format_ip({a,b,c,d}) do
    ( 16777216 * a ) + ( 65536 * b ) + ( 256 * c ) + d
  end


end