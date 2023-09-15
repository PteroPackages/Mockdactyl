module Mockdactyl
  @[ADI::Register]
  class Authenticate
    include AED::EventListenerInterface

    @[AEDA::AsEventListener]
    def authenticate(event : Athena::Framework::Events::Request)
      return unless event.request.path.starts_with? "/api"

      headers = event.request.headers
      fail_unauthorized! unless headers.has_key? "Authorization"

      auth = headers["Authorization"]
      fail_unauthorized! unless auth.starts_with? "Bearer "

      _, token = auth.split ' '
      fail_unauthorized! unless token.starts_with? "ptlc_"

      token = token[5..]
      key = Store.api_keys.find { |k| k.token == token }
      fail_unauthorized! unless key
    end

    private def fail_unauthorized! : NoReturn
      raise ATH::Exceptions::Unauthorized.new "you are not authorised to access this resource", "Basic"
    end
  end
end
