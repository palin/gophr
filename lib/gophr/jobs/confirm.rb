module Gophr
  module Jobs
    class Confirm < Base
      protected

      def url
        "#{api_url}/confirm-job"
      end
    end
  end
end
