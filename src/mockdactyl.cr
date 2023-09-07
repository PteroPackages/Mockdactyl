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
    get "/" do
      "Hello World"
    end
  end
end
