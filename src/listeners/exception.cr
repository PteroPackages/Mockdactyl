module Mockdactyl::Listeners
  @[ADI::Register]
  class Exception
    include AED::EventListenerInterface

    @[AEDA::AsEventListener]
    def on_exception(event : ATH::Events::Exception)
      # Do nothing for now
    end
  end
end
