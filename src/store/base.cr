module Mockdactyl::Store
  class_getter locations = Locations.new
  class_getter users = Users.new
  class_getter api_keys = APIKeys.new
end
