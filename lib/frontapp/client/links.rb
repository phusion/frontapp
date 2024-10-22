module Frontapp
  class Client
    module Links

      def links(params = {})
        cleaned = params.permit({ q: [:statuses] })
        list("links", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -------------------------------
      # link_id  string  Id of the requested link
      # -------------------------------
      def get_link(link_id)
        get("links/#{link_id}")
      end

      # Allowed attributes:
      # Name          Type               Description
      # ------------------------------------
      # name          string (optional)  Name of the link. If none is specified, the external_url is used as a default
      # external_url  string             Underlying identifying link/url of the link
      # ------------------------------------
      def create_link!(params = {})
        cleaned = params.permit(:name, :external_url)
        create("links", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # link_id  string  Id of the requested link
      # -----------------------------
      #
      # Allowed attributes:
      # Name  Type    Description
      # ------------------------------------
      # name  string  New name of the link
      # ------------------------------------
      def update_link!(link_id, params = {})
        cleaned = params.permit(:name)
        update("links/#{link_id}", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # link_id  string  Id of the requested link
      # -----------------------------
      #
      # Allowed params:
      # Name        Type               Description
      # ------------------------------------------
      # q           object (optional)  Search query.
      # q.statuses  array (optional)   List of the statuses of the conversations you want to list
      # ------------------------------------------
      def get_link_conversations(link_id, params = {}, &)
        cleaned = params.permit({ q: [:statuses] })
        list("links/#{link_id}/conversations", cleaned, &)
      end
    end
  end
end
