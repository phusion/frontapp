module Frontapp
  class Error < StandardError
    def self.from_response(response)
      error_class = case response.status
        when 400 then BadRequestError
        when 401 then UnauthorizedError
        when 404 then NotFoundError
        when 409 then ConflictError
        when 429 then TooManyRequestsError
        else self
        end
      error_class.new(response)
    end

    attr_reader :response

    def initialize(response)
      @response = response
      super("Response Body: #{response.body}")
    end
  end

  class BadRequestError < Error; end
  class NotFoundError < Error; end
  class ConflictError < Error; end
  class UnauthorizedError < Error; end
  class TooManyRequestsError < Error; end
end
