module Mockdactyl
  @[ADI::Register(alias: Athena::Framework::ErrorRendererInterface)]
  struct ErrorInterface
    include ATH::ErrorRendererInterface

    def render(exception : ::Exception) : ATH::Response
      headers = HTTP::Headers{"Content-Type" => "application/json; charset=UTF-8"}

      if exception.is_a? Exceptions::Base
        return ATH::Response.new exception.to_json, exception.status, headers
      end

      ATH::Response.new exception.to_json, :internal_server_error, headers
    end
  end
end
