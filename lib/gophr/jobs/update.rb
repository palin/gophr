module Gophr
  module Jobs
    class Update < Base
      protected

      def url
        "#{api_url}/update-job"
      end
    end
  end
end
