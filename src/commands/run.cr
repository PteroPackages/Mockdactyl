module Mockdactyl::Commands
  @[ACONA::AsCommand("app:run")]
  @[ADI::Register]
  class Run < ACON::Command
    protected def configure : Nil
      self.help "Runs the Mockdactyl server"
    end

    protected def execute(input : ACON::Input::Interface, output : ACON::Output::Interface) : ACON::Command::Status
      ATH.run

      ACON::Command::Status::SUCCESS
    end
  end
end
