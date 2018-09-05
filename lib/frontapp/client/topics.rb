module Frontapp
  class Client
    module Topics

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # topic_id  string  Id of the requested topic
      # -----------------------------
      #
      # Allowed params:
      # Name        Type               Description
      # ------------------------------------------
      # q           object (optional)  Search query.
      # q.statuses  array (optional)   List of the statuses of the conversations you want to list
      # ------------------------------------------
      def get_topic_conversations(topic_id, params = {})
        cleaned = params.permit({ q: [:statuses] })
        list("topics/#{topic_id}/conversations", cleaned)
      end
    end
  end
end