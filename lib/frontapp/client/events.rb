module Frontapp
  class Client
    module Events

      def events(params = {})
        list("/events", params)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # event_id  string  Id of the requested event
      # -----------------------------
      def get_event(event_id)
        get("/events/#{event_id}")
      end

    end
  end
end
