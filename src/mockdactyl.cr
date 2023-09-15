require "athena"
require "faker"
require "json"
require "uuid"

require "./controllers/application/*"
require "./middleware/*"
require "./models/*"
require "./store/*"

module Mockdactyl
  VERSION = "0.1.0"

  class App < ATH::Controller
    get "/" do
      "Hello World"
    end

    @[ARTA::Post("/keygen")]
    def keygen : Mockdactyl::FractalItem(Mockdactyl::APIKey)
      key = Store.api_keys.create "auto-generated api key", nil

      FractalItem.new(key, {"secret_token" => JSON::Any.new(key.token)})
    end
  end
end
