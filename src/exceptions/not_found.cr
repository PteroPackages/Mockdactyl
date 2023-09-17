module Mockdactyl::Exceptions
  class NotFound < Base
    def initialize
      super 404, [
        Issue.new(404, "NotFoundHttpException", "The requested resource could not be found on the server."),
      ]
    end
  end
end
