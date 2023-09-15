class Array(T)
  def to_json
    data = map { |i| Mockdactyl::FractalItem.new i }
    Mockdactyl::FractalList(T).new(data).to_json
  end
end

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
