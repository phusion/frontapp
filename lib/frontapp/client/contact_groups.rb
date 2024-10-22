module Frontapp
  class Client
    module ContactGroups

      def contact_groups(params = {}, &)
        list("contact_groups", params, &)
      end

      # Allowed attributes:
      # Name          Type              Description
      # -------------------------------------------
      # name          string            Name of the group
      # -------------------------------------------
      def create_contact_group!(params = {})
        cleaned = params.permit(:name)
        create("contact_groups", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -------------------------------
      # group_id  string  Id of the requested group
      # -------------------------------
      def delete_contact_group!(group_id)
        delete("contact_groups/#{group_id}")
      end


      # Parameters
      # Name      Type    Description
      # -------------------------------
      # group_id  string  Id of the requested group
      # -------------------------------
      def get_contact_group_contacts(group_id)
        get("contact_groups/#{group_id}/contacts")
      end

      # Parameters
      # Name      Type    Description
      # -------------------------------
      # group_id  string  Id of the requested group
      # -------------------------------
      #
      # Allowed attributes:
      # Name         Type   Description
      # --------------------------------------------
      # contact_ids  array  List of ids or aliases of the contacts to add in the requested group
      # --------------------------------------------
      def add_contacts_to_contact_group!(group_id, params = {})
        cleaned = params.permit(:contact_ids)
        create_without_response("contact_groups/#{group_id}/contacts", cleaned)
      end
    end
  end
end