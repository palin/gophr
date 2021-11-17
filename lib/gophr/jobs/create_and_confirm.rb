# frozen_string_literal: true

module Gophr
  module Jobs
    class CreateAndConfirm < Base
      protected

      def url
        "#{api_url}/create-confirm-job"
      end
    end
  end
end
