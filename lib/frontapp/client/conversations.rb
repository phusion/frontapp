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
      # conversation_id     string            The conversation Id
      # link_ids            array (optional)  Link IDs to add Either link_ids or link_external_urls must be specified but not both
      # link_external_urls  array (optional)  Link external urls to add. Creates links if necessary. Either link_ids or link_external_urls must be specified but not both
      # ----------------------------------------------
      def add_conversation_links!(conversation_id, params = {})
        cleaned = params.permit(:link_ids, :link_external_urls)
        create_without_response("conversations/#{conversation_id}/links", cleaned)
      end

      # Parameters
      # Name             Type              Description
      # ----------------------------------------------
      # conversation_id  string            The conversation Id
      # link_ids        array of strings  link IDs to remove
      # ----------------------------------------------
      def remove_conversation_links!(conversation_id, params = {})
        cleaned = params.permit(:link_ids)
        delete("conversations/#{conversation_id}/links", cleaned)
      end

      # Parameters
      # Name             Type              Description
      # ----------------------------------------------
      # conversation_id  string            The conversation Id
      # teammate_ids     array of strings  follower IDs to remove
      # ----------------------------------------------
      def remove_conversation_followers!(conversation_id, params = {})
        cleaned = params.permit(:teammate_ids)
        delete("conversations/#{conversation_id}/followers", cleaned)
      end

      # Parameters
      # Name             Type              Description
      # ----------------------------------------------
      # conversation_id  string            The conversation Id
      # teammate_ids     array of strings  follower IDs to add
      # ----------------------------------------------
      def add_conversation_followers!(conversation_id, params = {})
        cleaned = params.permit(:teammate_ids)
        create_without_response("conversations/#{conversation_id}/followers", cleaned)
      end
    end
  end
end
