class TouristSight
  attr_reader :id, :name, :address, :place_id
  
  def initialize(tourist_sight_info)
    @id = nil
    @name = tourist_sight_info[:properties][:name]
    @address = tourist_sight_info[:properties][:formatted]
    @place_id = tourist_sight_info[:properties][:place_id]
  end
end