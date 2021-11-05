module Gophr
  module Jobs
    class GetStatus < Base
      protected

      def url
        "#{api_url}/get-job-status"
      end
    end
  end
end
