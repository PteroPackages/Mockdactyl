module Mockdactyl::Application
  class Users < ATH::Controller
    @[ARTA::Get("/api/application/users")]
    def list : String
      data = Store.users.values.map { |u| FractalItem(User).new u }

      FractalList(User).new(data).to_json
    end

    @[ARTA::Get("/api/application/users/{id}")]
    def index(id : Int32) : String
      user = Store.users[id]? || raise ATH::Exceptions::NotFound.new "the requested user was not found"

      FractalItem(User).new(user).to_json
    end
  end
end
