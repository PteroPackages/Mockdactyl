module Mockdactyl
  class APIKey
    include JSON::Serializable

    getter identifier : String
    @[JSON::Field(ignore: true)]
    getter token : String
    property description : String?
    property allowed_ips : Array(String)
    @created_at : String
    @[JSON::Field(emit_null: true)]
    @last_used_at : String?

    def initialize(@token, @description, @allowed_ips)
      @identifier = token[0...8]
      @created_at = Time.utc.to_s
    end

    def key : String
      "api_key"
    end
  end
end
