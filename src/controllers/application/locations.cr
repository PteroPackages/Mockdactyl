module Mockdactyl::Application
  @[ARTA::Route(path: "/api/application/locations")]
  class Locations < ATH::Controller
    @[ARTA::Get("")]
    def list : Array(Mockdactyl::Location)
      Store.locations.list
    end

    @[ARTA::Get("/{id}")]
    def index(id : Int32) : Mockdactyl::Location
      Store.locations.index(id) || raise Exceptions::NotFound.new
    end

    @[ARTA::Post("")]
    def create(
      @[ATHR::RequestBody::Extract]
      data : Mockdactyl::LocationCreate
    ) : Mockdactyl::Location
      Store.locations.create data
    end

    @[ARTA::Patch("/{id}")]
    def update(
      id : Int32,
      @[ATHR::RequestBody::Extract]
      data : Mockdactyl::LocationUpdate
    ) : Mockdactyl::Location
      location = Store.locations.index(id) || raise Exceptions::NotFound.new

      Store.locations.update location, data
    end

    @[ARTA::Delete("/{id}")]
    def delete(id : Int32) : Nil
      Store.users.delete(id) || raise Exceptions::NotFound.new
    end
  end
end
