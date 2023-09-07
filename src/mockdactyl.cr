require "athena"
require "faker"
require "json"
require "uuid"

require "./controllers/application/*"
require "./models/*"
require "./store"

module Mockdactyl
  VERSION = "0.1.0"

  class App < ATH::Controller
    @@random = Random.new

    get "/" do
      "Hello World"
    end

    post "/keygen" do
      key = ApiKey.new @@random.hex(32), "auto-generated api-key"
      Store.api_keys[key.identifier] = key

      FractalItem(ApiKey).new(key).to_json
    end
  end
end
