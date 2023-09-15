module Mockdactyl::Application
  @[ARTA::Route(path: "/api/application/users")]
  class Users < ATH::Controller
    @[ARTA::Get("")]
    def list : Mockdactyl::FractalList(Mockdactyl::User)
      data = Store.users.list.map { |u| FractalItem.new u }

      FractalList.new data
    end

    @[ARTA::Get("{id}")]
    def index(id : Int32) : Mockdactyl::FractalItem(Mockdactyl::User)
      user = Store.users.index(id) || fail_not_found!

      FractalItem.new user
    end

    @[ARTA::Get("external/{id}")]
    def external(id : String) : Mockdactyl::FractalItem(Mockdactyl::User)
      user = Store.users.index(id) || fail_not_found!

      FractalItem.new user
    end

    @[ARTA::Post("")]
    def create(
      @[ATHR::RequestBody::Extract]
      data : Mockdactyl::UserCreate
    ) : Mockdactyl::FractalItem(Mockdactyl::User)
      user = Store.users.create data

      FractalItem.new user
    end

    private def fail_not_found! : NoReturn
      raise ATH::Exceptions::NotFound.new "the requested user was not found"
    end
  end
end
