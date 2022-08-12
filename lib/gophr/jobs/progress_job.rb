# frozen_string_literal: true

module Gophr
  module Jobs
    class ProgressJob < Base
      protected

      def url
        "#{api_url}/progress-job"
      end
    end
  end
end
