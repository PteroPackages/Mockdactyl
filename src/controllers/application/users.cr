module Mockdactyl::Application
  class Users < ATH::Controller
    @[ARTA::Get("/api/application/users")]
    def list : Mockdactyl::FractalList(Mockdactyl::User)
      data = Store.users.values.map { |u| FractalItem(User).new u }

      FractalList(User).new data
    end

    @[ARTA::Get("/api/application/users/{id}")]
    def index(id : Int32) : Mockdactyl::FractalItem(Mockdactyl::User)
      user = Store.users[id]? || fail_not_found!

      FractalItem(User).new user
    end

    @[ARTA::Get("/api/application/users/external/{id}")]
    def external(id : String) : Mockdactyl::FractalItem(Mockdactyl::User)
      user = Store.users.values.find { |u| u.external_id == id }
      fail_not_found! unless user

      FractalItem(User).new user
    end

    private def fail_not_found! : NoReturn
      raise ATH::Exceptions::NotFound.new "the requested user was not found"
    end
  end
end
