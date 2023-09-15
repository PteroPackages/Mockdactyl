module Mockdactyl
  class FractalItem(T)
    include JSON::Serializable

    @object : String
    @attributes : T
    @meta : JSON::Any?

    def initialize(@attributes, meta = nil)
      @object = attributes.key
      @meta = JSON::Any.new meta if meta
    end
  end

  class FractalList(T)
    include JSON::Serializable

    @object = "list"
    @data : Array(FractalItem(T))

    def initialize(@data)
    end
  end
end
