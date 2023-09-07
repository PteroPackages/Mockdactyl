require "athena"
require "faker"
require "json"
require "uuid"

require "./controllers/application/*"
require "./middleware/*"
require "./models/*"
require "./store"

module Mockdactyl
  VERSION = "0.1.0"

  class App < ATH::Controller
    @@random = Random.new

    get "/" do
      "Hello World"
    end

    @[ARTA::Post("/keygen")]
    def keygen : Mockdactyl::FractalItem(Mockdactyl::ApiKey)
      key = ApiKey.new @@random.hex(32), "auto-generated api-key"
      Store.api_keys[key.identifier] = key
      meta = {"secret_token" => JSON::Any.new(key.token)}

      FractalItem(ApiKey).new(key, JSON::Any.new(meta))
    end
  end
end
