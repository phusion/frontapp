module Frontapp
  class Client
    module Inboxes

      def inboxes(params = {}, &)
        list("inboxes", params, &)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # inbox_id  string  Id of the requested inbox
      # -----------------------------
      def get_inbox(inbox_id)
        get("inboxes/#{inbox_id}")
      end

      # Allowed attributes:
      # Name          Type              Description
      # -------------------------------------------
      # name          string            Name of the inbox
      # teammate_ids  array (optional)  List of all the teammate ids who will have access to this inbox. If omitted, it will automatically select all the administrators in your company.
      # -------------------------------------------
      def create_inbox!(params = {})
        cleaned = params.permit(:name, :teammate_ids)
        create("inboxes", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # inbox_id  string  Id of the requested inbox
      # -----------------------------
      def get_inbox_channels(inbox_id)
        get("inboxes/#{inbox_id}/channels")
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # inbox_id  string  Id of the requested inbox
      # -----------------------------
      #
      # Allowed attributes:
      # Name        Type               Description
      # ----------------------------------------------
      # q           object (optional)  Search query.
      # q.statuses  array (optional)   List of the statuses of the conversations you want to list
      # ----------------------------------------------
      def get_inbox_conversations(inbox_id, params = {}, &)
        cleaned = params.permit({ q: [:statuses] })
        list("inboxes/#{inbox_id}/conversations", cleaned, &)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # inbox_id  string  Id of the requested inbox
      # -----------------------------
      def get_inbox_teammates(inbox_id)
        get("inboxes/#{inbox_id}/teammates")
      end

    end
  end
end