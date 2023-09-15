module Mockdactyl::Store
  class APIKeys
    @data : Array(APIKey)
    @random : Random

    def initialize
      @data = [] of APIKey
      @random = Random.new
    end

    def index(token : String) : APIKey?
      @data.find { |k| k.token == token }
    end

    def create(description : String?, allowed_ips : Array(String)?) : APIKey
      key = APIKey.new(@random.hex(16), description, allowed_ips || %w[])
      @data << key

      key
    end
  end
end
