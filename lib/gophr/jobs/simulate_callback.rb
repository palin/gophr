module Gophr
  module Jobs
    class SimulateCallback < Base
      protected

      def url
        "#{api_url}/simulate-callback"
      end
    end
  end
end
