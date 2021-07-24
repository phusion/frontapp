module Frontapp
  class Client
    module Conversations

      def conversations(params = {})
        list("conversations", params)
      end

      # Parameters
      # Name             Type    Description
      # ------------------------------------
      # conversation_id  string  Id of the requested conversation
      # ------------------------------------
      def get_conversation(conversation_id)
        get("conversations/#{conversation_id}")
      end

      # Parameters
      # Name             Type    Description
      # ------------------------------------
      # conversation_id  string  Id of the requested conversation
      # ------------------------------------
      #
      # Allowed attributes:
      # Name          Type                Description
      # ---------------------------------------------
      # assignee_id   string (optional)   ID of the teammate to assign the conversation to. Set it to null to unassign.
      # inbox_id      string (optional)   ID of the inbox to move the conversation to.
      # status        enum (optional)     New status of the conversation
      # tags          array (optional)    List of all the tag names replacing the old conversation tags
      # ---------------------------------------------
      # The assignee id is their Frontapp handle, e.g. @username
      def update_conversation!(conversation_id, params = {})
        cleaned = params.permit(:assignee_id, :inbox_id, :status, :tags)
        update("conversations/#{conversation_id}", cleaned)
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # conversation_id  string  Id or email of the requested conversation
      # --------------------------------
      def get_conversation_inboxes(conversation_id)
        get("conversations/#{conversation_id}/inboxes")
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # conversation_id  string  Id or email of the requested conversation
      # --------------------------------
      def get_conversation_followers(conversation_id)
        get("conversations/#{conversation_id}/followers")
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # conversation_id  string  Id or email of the requested conversation
      # --------------------------------
      def get_conversation_events(conversation_id)
        list("conversations/#{conversation_id}/events")
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # conversation_id  string  Id or email of the requested conversation
      # --------------------------------
      def get_conversation_messages(conversation_id)
        list("conversations/#{conversation_id}/messages")
      end

      # Parameters
      # Name             Type              Description
      # ----------------------------------------------
      # conversation_id  string            The conversation Id
      # topic_ids        array (optional)  Topic IDs to add Either topic_ids or topic_links must be specified but not both
      # topic_links      array (optional)  Topic links to add. Creates topics if necessary. Either topic_ids or topic_links must be specified but not both
      # ----------------------------------------------
      def add_conversation_topics!(conversation_id, params = {})
        cleaned = params.permit(:topic_ids, :topic_links)
        create_without_response("conversations/#{conversation_id}/topics", cleaned)
      end

      # Parameters
      # Name             Type              Description
      # ----------------------------------------------
      # conversation_id  string            The conversation Id
      # topic_ids        array of strings  Topic IDs to remove
      # ----------------------------------------------
      def remove_conversation_topics!(conversation_id, params = {})
        cleaned = params.permit(:topic_ids)
        delete("conversations/#{conversation_id}/topics", cleaned)
      end
    end
  end
end
