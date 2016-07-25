module Gophr
  module Jobs
    class CancelationCost < Base
      protected

      def url
        "#{api_url}/get-cancelation-cost"
      end
    end
  end
end
