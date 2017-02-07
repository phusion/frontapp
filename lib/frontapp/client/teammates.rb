module Frontapp
  class Client
    module Teammates

      def teammates(params = {})
        list("teammates", params)
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # teammate_id  string  Id or email of the requested teammate
      # --------------------------------
      def get_teammate(teammate_id)
        get("teammates/#{teammate_id}")
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # teammate_id  string  Id or email of the requested teammate
      # --------------------------------
      #
      # Allowed attributes:
      # Name          Type                Description
      # ----------------------------------------------
      # username      string (optional)   New username. It must be unique and can only contains lowercase letters, numbers and underscores.
      # first_name    string (optional)   New first name
      # last_name     string (optional)   New last name
      # is_admin      boolean (optional)  New admin status
      # is_available  boolean (optional)  New availability status
      # ----------------------------------------------
      def update_teammate!(teammate_id, params = {})
        cleaned = params.permit(:username, :first_name, :last_name, :is_admin, :is_available)
        update("teammates/#{teammate_id}", cleaned)
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # teammate_id  string  Id or email of the requested teammate
      # --------------------------------
      #
      # Allowed params:
      # Name        Type               Description
      # ----------------------------------------------
      # q           object (optional)  Search query. 
      # q.statuses  array (optional)   List of the statuses of the conversations you want to list
      # ----------------------------------------------
      def get_teammate_conversations(teammate_id, params = {})
        cleaned = params.permit({ q: [:statuses] })
        list("teammates/#{teammate_id}/conversations", cleaned)
      end

      # Parameters
      # Name         Type    Description
      # --------------------------------
      # teammate_id  string  Id or email of the requested teammate
      # --------------------------------
      def get_teammate_inboxes(teammate_id)
        get("teammates/#{teammate_id}/inboxes")
      end

    end
  end
end