module Frontapp
  class Error < StandardError
    def self.from_response(response)
      error_class = case response.status
        when 400 then BadRequestError
        when 404 then NotFoundError
        when 409 then ConflictError
        else self.class
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
end
