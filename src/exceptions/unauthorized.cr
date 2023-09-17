module Mockdactyl::Exceptions
  class Unauthorized < Base
    def initialize
      super 401, [Issue.new(401, "AuthenticationException", "Unauthenticated.")]
    end
  end
end
