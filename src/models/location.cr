module Mockdactyl
  class Location
    include JSON::Serializable

    getter id : Int32
    property short : String
    property long : String?
    getter created_at : String
    property updated_at : String?

    def initialize(@id, @short, @long)
      @created_at = Time.utc.to_s
    end

    def key : String
      "location"
    end

    def to_json : String
      FractalItem.new(self).to_json
    end
  end

  class LocationCreate
    include AVD::Validatable
    include JSON::Serializable

    @[Assert::NotBlank]
    @[Assert::Size(1..4)]
    getter short : String
    getter long : String
  end

  class LocationUpdate
    include AVD::Validatable
    include JSON::Serializable

    @[Assert::Size(1..4)]
    getter short : String?
    getter long : String?
  end
end
