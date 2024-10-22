module Frontapp
  class Client
    module Tags

      def tags(params = {}, &)
        list("tags", params, &)
      end

      # Parameters
      # Name    Type    Description
      # ---------------------------
      # tag_id  string  Id of the requested tag
      # ---------------------------
      def get_tag(tag_id)
        get("tags/#{tag_id}")
      end

      # Allowed attributes:
      # Name  Type    Description
      # -------------------------
      # name  string  Name of the tag to create
      # -------------------------
      def create_tag!(params = {})
        cleaned = params.permit(:name)
        create("tags", cleaned)
      end

      # Parameters
      # Name    Type    Description
      # ---------------------------
      # tag_id  string  Id of the requested tag
      # ---------------------------
      #
      # Allowed params:
      # Name        Type               Description
      # ----------------------------------------------
      # q           object (optional)  Search query.
      # q.statuses  array (optional)   List of the statuses of the conversations you want to list
      # ----------------------------------------------
      def get_tag_conversations(tag_id, params = {}, &)
        cleaned = params.permit({ q: [:statuses] })
        list("tags/#{tag_id}/conversations", cleaned, &)
      end

      # Parameters
      # Name    Type    Description
      # ---------------------------
      # tag_id  string  Id of the requested tag
      # ---------------------------
      def delete_tag!(tag_id)
        delete("tags/#{tag_id}")
      end

    end
  end
end