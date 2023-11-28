module Mockdactyl::Store
  class Locations
    @inc : Int32
    @data : Array(Location)
    @random : Random

    def initialize
      @inc = 2
      @data = [Location.new(1, Faker::Address.country_code, Faker::Address.country)]
      @random = Random.new
    end

    def list : Array(Location)
      @data
    end

    def index(id : Int32) : Location?
      @data.find { |l| l.id == id }
    end

    def create(data : LocationCreate) : Location
      location = Location.new(@inc += 1, data.short, data.long)
      @data << location

      location
    end

    def update(location : Location, data : LocationUpdate) : Location
      if short = data.short
        location.short = short
      end

      if long = data.long
        location.long = long
      end

      location
    end

    def delete(id : Int32) : Bool
      pos = @data.index { |l| l.id == id } || return false
      @data.delete_at pos

      true
    end
  end
end
