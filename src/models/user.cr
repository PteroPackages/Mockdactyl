module Mockdactyl
  class User
    include JSON::Serializable

    getter id : Int32
    @[JSON::Field(emit_null: true)]
    property external_id : String?
    getter uuid : String
    property username : String
    property email : String
    property first_name : String
    property last_name : String
    property language : String
    property? root_admin : Bool
    @[JSON::Field(key: "2fa")]
    property? two_factor : Bool
    getter created_at : String
    @[JSON::Field(emit_null: true)]
    property updated_at : String?

    def initialize(@id, @external_id, @uuid, @username, @email, @first_name, @last_name, @language, @root_admin)
      @two_factor = false
      @created_at = Time.utc.to_s
    end

    def key : String
      "user"
    end

    def to_json : String
      FractalItem.new(self).to_json
    end
  end

  class UserCreate
    include AVD::Validatable
    include JSON::Serializable

    @[Assert::Size(1...59)]
    getter external_id : String?
    @[Assert::NotBlank]
    @[Assert::Size(1...59)]
    getter username : String
    @[Assert::Email]
    @[Assert::NotBlank]
    getter email : String
    @[Assert::NotBlank]
    @[Assert::Size(1...59)]
    getter first_name : String
    @[Assert::NotBlank]
    @[Assert::Size(1...59)]
    getter last_name : String
    @[Assert::Size(0...4)]
    getter language : String = "en"
    # ameba:disable Style/QueryBoolMethods
    getter root_admin : Bool = false
  end

  class UserUpdate
    include AVD::Validatable
    include JSON::Serializable

    @[Assert::Size(1...59)]
    getter external_id : String?
    @[Assert::NotBlank]
    @[Assert::Size(1...59)]
    getter username : String
    @[Assert::Email]
    @[Assert::NotBlank]
    getter email : String
    @[Assert::NotBlank]
    @[Assert::Size(1...59)]
    getter first_name : String
    @[Assert::NotBlank]
    @[Assert::Size(1...59)]
    getter last_name : String
    @[Assert::Size(0...4)]
    getter language : String?
    getter root_admin : Bool?
  end
end
