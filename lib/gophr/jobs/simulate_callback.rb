module Gophr
  module Jobs
    class SimulateCallback < Base
      def call
        response = HTTParty.post(url, headers: headers, body: body)

        if response.code == 200
          response.parsed_response
        else
          Gophr::HTTPError.new(response)
        end
      end

      protected

      def url
        "#{api_url}/simulate-callback"
      end
    end
  end
end
