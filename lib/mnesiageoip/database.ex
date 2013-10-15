use Amnesia

# defines a database called Database, it's basically a defmodule with
# some additional magic
defdatabase Mnesiageoip.Database do
  deftable Country, [:ipstart, :ipend, :countrycode, :country], type: :ordered_set, index: [:ipstart, :ipend] do
  
  end

  deftable CityBlock, [:ipstart, :ipend, :cityid], type: :ordered_set, index: [:ipstart, :ipend] do
  
  end

  deftable CityLocation, [:id, :country, :state, :city, :postalcode, :lat, :long, :metrocode, :areacode], type: :ordered_set, index: [:id] do
  
  end
end