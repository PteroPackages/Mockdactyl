module Mockdactyl::Application
  @[ARTA::Route(path: "/api/application/users")]
  class Users < ATH::Controller
    @[ARTA::Get("")]
    def list : Array(Mockdactyl::User)
      Store.users.list
    end

    @[ARTA::Get("/{id}")]
    def index(id : Int32) : Mockdactyl::User
      Store.users.index(id) || raise Exceptions::NotFound.new
    end

    @[ARTA::Get("/external/{id}")]
    def external(id : String) : Mockdactyl::User
      Store.users.index(id) || raise Exceptions::NotFound.new
    end

    @[ARTA::Post("")]
    def create(
      @[ATHR::RequestBody::Extract]
      data : Mockdactyl::UserCreate
    ) : Mockdactyl::User
      Store.users.create data
    end

    @[ARTA::Patch("/{id}")]
    def update(
      id : Int32,
      @[ATHR::RequestBody::Extract]
      data : Mockdactyl::UserUpdate
    ) : Mockdactyl::User
      user = Store.users.index(id) || raise Exceptions::NotFound.new

      Store.users.update user, data
    end

    @[ARTA::Delete("/{id}")]
    def delete(id : Int32) : Nil
      Store.users.delete(id) || raise Exceptions::NotFound.new
    end
  end
end
