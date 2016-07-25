module Gophr
  module Jobs
    class Cancel < Base
      protected

      def url
        "#{api_url}/cancel-job"
      end
    end
  end
end
