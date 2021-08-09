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
        warn "[DEPRECATION] `Topics` is deprecated.  Please use `Links` instead."

        get_link_conversations(topic_id, params)
      end
    end
  end
end
