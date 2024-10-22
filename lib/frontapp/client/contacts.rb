module Frontapp
  class Client
    module Contacts

      def contacts(params = {})
        list("contacts", params)
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      def get_contact(contact_id)
        get("contacts/#{contact_id}")
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      #
      # Allowed attributes:
      # Name         Type                Description
      # --------------------------------------------
      # name          string (optional)   Contact name
      # description   string (optional)   Contact description
      # avatar_url    string (optional)   URL of the contact’s avatar
      # is_spammer    boolean (optional)  Whether or not the contact is marked as a spammer
      # links         array (optional)    List of all the links of the contact
      # group_names   array (optional)    List of all the group names the contact belongs to. It will automatically create missing groups.
      # custom_fields object (optional)   Custom field attributes for this contact. Leave empty if you do not wish to update the attributes. Not sending existing attributes will automatically remove them.
      # --------------------------------------------
      def update_contact!(contact_id, params = {})
        cleaned = params.permit(:name,
                                :description,
                                :avatar_url,
                                :is_spammer,
                                :links,
                                :group_names,
                                :custom_fields)
        update("contacts/#{contact_id}", cleaned)
      end

      # Allowed attributes:
      # Name         Type                Description
      # --------------------------------------------
      # name         string (optional)   Contact name
      # description  string (optional)   Contact description
      # avatar_url   string (optional)   URL of the contact’s avatar
      # is_spammer   boolean (optional)  Whether or not the contact is marked as a spammer
      # links        array (optional)    List of all the links of the contact
      # group_names  array (optional)    List of all the group names the contact belongs to. It will automatically create missing groups.
      # handles      array               List of the contact handles
      # custom_fields object (optional)  Custom field attributes for this contact. Leave empty if you do not wish to update the attributes. Not sending existing attributes will automatically remove them.
      # --------------------------------------------
      def create_contact!(params = {})
        cleaned = params.permit(:name,
                                :description,
                                :avatar_url,
                                :is_spammer,
                                :links,
                                :group_names,
                                :handles,
                                :custom_fields)
        create("contacts", cleaned)
      end

      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      def delete_contact!(contact_id)
        delete("contacts/#{contact_id}")
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      #
      # Allowed params:
      # Name        Type               Description
      # ----------------------------------------------
      # q           object (optional)  Search query.
      # q.statuses  array (optional)   List of the statuses of the conversations you want to list
      # ----------------------------------------------
      def get_contact_conversations(contact_id, params = {}, &)
        cleaned = params.permit({ q: [:statuses] })
        list("contacts/#{contact_id}/conversations", cleaned, &)
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      #
      # Allowed attributes:
      # Name    Type    Description
      # ---------------------------
      # handle  string  Handle used to reach the contact. Can be an email address, a twitter, handle, a phone number, …
      # source  enum    Can be 'twitter’, 'email’ or 'phone’.
      # ---------------------------
      def add_contact_handle!(contact_id, params = {})
        cleaned = params.permit(:handle, :source)
        create_without_response("contacts/#{contact_id}/handles", cleaned)
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      #
      # Allowed attributes:
      # Name    Type                Description
      # ---------------------------------------
      # handle  string              Handle used to reach the contact. Can be an email address, a twitter, handle, a phone number, …
      # source  enum                Can be 'twitter’, 'email’ or 'phone’.
      # force   boolean (optional)  Force the deletetion of the contact if the handle is the last one
      # ---------------------------------------
      def delete_contact_handle!(contact_id, params = {})
        cleaned = params.permit(:handle, :source, :force)
        delete("contacts/#{contact_id}/handles", cleaned)
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      def get_contact_notes(contact_id)
        list("contacts/#{contact_id}/notes")
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # contact_id  string  Id or alias of the requested contact
      # -------------------------------
      #
      # Allowed attributes:
      # Name       Type    Description
      # ------------------------------
      # author_id  string  Id of the teammate creating the note
      # body       string  Content of the note
      # ------------------------------
      def add_contact_note!(contact_id, params = {})
        cleaned = params.permit(:author_id, :body)
        create("contacts/#{contact_id}/notes", cleaned)
      end

    end
  end
end
