module Mockdactyl::Application
  @[ARTA::Route(path: "/api/application/users")]
  class Users < ATH::Controller
    @[ARTA::Get("")]
    def list : Mockdactyl::FractalList(Mockdactyl::User)
      data = Store.users.map { |u| FractalItem(User).new u }

      FractalList(User).new data
    end

    @[ARTA::Get("{id}")]
    def index(id : Int32) : Mockdactyl::FractalItem(Mockdactyl::User)
      user = Store.users.find { |u| u.id == id } || fail_not_found!

      FractalItem(User).new user
    end

    @[ARTA::Get("external/{id}")]
    def external(id : String) : Mockdactyl::FractalItem(Mockdactyl::User)
      user = Store.users.find { |u| u.external_id == id } || fail_not_found!

      FractalItem(User).new user
    end

    private def fail_not_found! : NoReturn
      raise ATH::Exceptions::NotFound.new "the requested user was not found"
    end
  end
end
