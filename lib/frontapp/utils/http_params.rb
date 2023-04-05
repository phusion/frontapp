module Frontapp
  module Utils
    module HttpParams
      # URI.encode was removed in Ruby 3.0
      # This method performs the same thing
      def uri_encode(value)
        URI::DEFAULT_PARSER.escape(value.to_s)
      end
    end
  end
end
