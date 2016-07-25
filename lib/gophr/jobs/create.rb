module Gophr
  module Jobs
    class Create < Base
      protected

      def url
        "#{api_url}/create-job"
      end
    end
  end
end
