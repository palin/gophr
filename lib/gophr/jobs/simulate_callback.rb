module Gophr
  module Jobs
    class SimulateCallback < Base
      attr_accessor :callback_url, :options

      def initialize(callback_url, options = {})
        @callback_url = callback_url
        @options = options
      end

      protected

      def url
        callback_url
      end
    end
  end
end
