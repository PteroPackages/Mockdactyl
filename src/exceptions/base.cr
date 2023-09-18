module Mockdactyl::Exceptions
  class Base < Exception
    getter status : Int32
    @issues : Array(Issue)

    def initialize(@status, @issues)
      super nil
    end

    def issue(code : String, detail : String) : Nil
      @issues << Issue.new @status, code, detail
    end

    def to_json : String
      {errors: @issues}.to_json
    end
  end

  struct Issue
    include JSON::Serializable

    @status : Int32
    @code : String
    @detail : String

    def initialize(@status, @code, @detail)
    end
  end
end
