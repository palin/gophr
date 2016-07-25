module Gophr
  module Jobs
    class Base
      attr_accessor :options

      def initialize(options = {})
        @options = options
      end

      def call
        response = HTTParty.post(url, headers: headers, body: body)

        if response.code == 200
          response = response.parsed_response

          if response['success'] == true
            response
          else
            Gophr::APIError.new(response)
          end
        else
          Gophr::HTTPError.new(response)
        end
      end

      protected

      def api_url
        Gophr.api_url
      end

      def headers
        { 'Content-Type' => 'application/x-www-form-urlencoded' }
      end

      def body
        {
          api_key: Gophr.api_key
        }.merge!(options)
      end
    end
  end
end
