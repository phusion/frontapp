module Frontapp
  class Error < StandardError
    def self.from_response(response)
      error_class = case response.status
        when 400 then BadRequestError
        when 401 then UnauthorizedError
        when 404 then NotFoundError
        when 409 then ConflictError
        when 429 then TooManyRequestsError
        when 504 then GatewayTimeoutError
        else self
        end
      error_class.new(response)
    end

    def initialize(response)
      @response = response
      super("Response: #{response.inspect}\nBody: #{response.body}")
    end
  end

  class BadRequestError < Error; end
  class NotFoundError < Error; end
  class ConflictError < Error; end
  class UnauthorizedError < Error; end
  class TooManyRequestsError < Error; end
  class GatewayTimeoutError < Error; end
end
