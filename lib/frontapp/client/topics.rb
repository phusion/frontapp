module Frontapp
  class Client
    module Topics

      def topics(params = {})
        cleaned = params.permit({ q: [:statuses] })
        list("topics", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -------------------------------
      # topic_id  string  Id of the requested topic
      # -------------------------------
      def get_topic(topic_id)
        get("topics/#{topic_id}")
      end

      # Allowed attributes:
      # Name  Type               Description
      # ------------------------------------
      # name  string (optional)  Name of the topic. If none is specified, the link is used as a default
      # link  string             Underlying identifying link/url of the topic
      # ------------------------------------
      def create_topic!(params = {})
        cleaned = params.permit(:name, :link)
        create("topics", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # topic_id  string  Id of the requested topic
      # -----------------------------
      #
      # Allowed attributes:
      # Name  Type    Description
      # ------------------------------------
      # name  string  New name of the topic
      # ------------------------------------
      def update_topic!(topic_id, params = {})
        cleaned = params.permit(:name)
        update("topics/#{topic_id}", cleaned)
      end

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
