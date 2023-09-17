module Mockdactyl
  @[ADI::Register]
  class Authenticate
    include AED::EventListenerInterface

    @[AEDA::AsEventListener]
    def authenticate(event : ATH::Events::Request)
      return unless event.request.path.starts_with? "/api"

      headers = event.request.headers
      raise Exceptions::Unauthorized.new unless headers.has_key? "Authorization"

      auth = headers["Authorization"]
      raise Exceptions::Unauthorized.new unless auth.starts_with? "Bearer "

      _, token = auth.split ' '
      raise Exceptions::Unauthorized.new unless token.starts_with? "ptlc_"

      token = token[5..]
      Store.api_keys.index(token) || raise Exceptions::Unauthorized.new
    end
  end
end
