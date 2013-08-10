class Location < ActiveRecord::Base
  self.table_name = "location"

  def name
    self.location_name
  end
end
