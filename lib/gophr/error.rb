module Gophr
  class Error
    attr_reader :response

    def initialize(response)
      @response = response
    end
  end

  class HTTPError < Error
  end

  class APIError < Error
  end
end
