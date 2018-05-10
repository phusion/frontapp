module Frontapp
  class Error < StandardError
    attr_reader :status_code
    attr_reader :context

    def initialize(status_code, context)
      @status_code = status_code
      @context = context
    end
  end

  class RateLimitError < Error
  end
end
