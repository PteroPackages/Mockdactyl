module Mockdactyl
  @[ADI::Register]
  class Authenticate
    include AED::EventListenerInterface

    @[AEDA::AsEventListener]
    def authenticate(event : Athena::Framework::Events::Request)
      headers = event.request.request.headers
      unless headers.has_key? "Authorization"
        raise ATH::Exceptions::Unauthorized.new "you are not authorised to access this resource", "asdf"
      end

      auth = headers["Authorization"]
      unless auth.starts_with? "Bearer "
        raise ATH::Exceptions::Unauthorized.new "you are not authorised to access this resource", "asdf"
      end

      _, token = auth.split ' '
      unless token.starts_with? "ptlc_"
        raise ATH::Exceptions::Unauthorized.new "you are not authorised to access this resource", "asdf"
      end

      key = Store.api_keys.values.find { |k| k.token == token }
      unless key
        raise ATH::Exceptions::Unauthorized.new "you are not authorised to access this resource", "asdf"
      end
    end
  end
end
