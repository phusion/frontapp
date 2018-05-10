module Frontapp
  class Client
    module Messages

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # message_id  string  Id of the requested message
      # -------------------------------
      def get_message(message_id)
        get("/messages/#{message_id}")
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # channel_id  string  Id or address of the channel from which to send the message
      # -------------------------------
      #
      # Allowed attributes:
      # Name             Type                Description
      # ------------------------------------------------
      # author_id        string (optional)   Id of the teammate on behalf of whom the answer is sent
      # subject          string (optional)   Subject of the message for email message
      # body             string              Body of the message
      # text             string (optional)   Text version of the body for messages with non-text body
      # options          object (optional)   Sending options
      # options.tags     array (optional)    List of tag names to add to the conversation (unknown tags will automatically be created)
      # options.archive  boolean (optional)  Archive the conversation right when sending the reply (Default: true)
      # to               array               List of the recipient handles who will receive this message
      # cc               array (optional)    List of the recipient handles who will receive a copy of this message
      # bcc              array (optional)    List of the recipient handles who will receive a blind copy of this message
      # ------------------------------------------------
      def send_message(channel_id, params)
        cleaned = params.permit(:author_id,
                                :subject,
                                :body,
                                :text,
                                { options: [:tags, :archive] },
                                :to,
                                :cc,
                                :bcc)
        create("/channels/#{channel_id}/messages", cleaned)
      end

      # Parameters
      # Name             Type    Description
      # ------------------------------------
      # conversation_id  string  Id of the conversation
      # ------------------------------------
      #
      # Allowed attributes:
      # Name             Type                Description
      # ------------------------------------------------
      # author_id        string (optional)   ID of the teammate on behalf of whom the answer is sent
      # subject          string (optional)   Subject of the message for email message
      # body             string              Body of the message
      # text             string (optional)   Text version of the body for messages with non-text body
      # options          object (optional)   Sending options
      # options.tags     array (optional)    List of tag names to add to the conversation (unknown tags will automatically be created)
      # options.archive  boolean (optional)  Archive the conversation right when sending the reply (Default: true)
      # channel_id       string (optional)   Channel through which to send the message. Defaults to the original conversation channel. For imported messages or messages received on multiple channels, you MUST specify a channel ID.
      # to               array (optional)    List of the recipient handles who will receive this message. By default it will use the recipients of the last received message.
      # cc               array (optional)    List of the recipient handles who will receive a copy of this message. By default it will use the cc'ed recipients of the last received message.
      # bcc              array (optional)    List of the recipient handles who will receive a blind copy of this message
      # ------------------------------------------------
      def send_reply(conversation_id, params)
        cleaned = params.permit(:author_id,
                                :subject,
                                :body,
                                :text,
                                { options: [:tags, :archive] },
                                :channel_id,
                                :to,
                                :cc,
                                :bcc)
        create_without_response("/conversations/#{conversation_id}/messages", cleaned)
      end

      # Parameters
      # Name        Type    Description
      # ------------------------------------
      # channel_id  string  Id of the requested custom channel
      # ------------------------------------
      #
      # Allowed attributes:
      # Name                  Type               Description
      # ----------------------------------------------------
      # sender                object             Data of the sender
      # sender.contact_id     string (optional)  ID of the contact in Front corresponding to the sender
      # sender.name           string (optional)  Name of the sender
      # sender.handle         string             Handle of the sender. It can be any string used to uniquely identify the sender
      # subject               string (optional)  Subject of the message
      # body                  string             Body of the message
      # body_format           enum (optional)    Format of the message body. (Default: 'markdown')
      # metadata              object (optional)
      # metadata.thread_ref   string (optional)  Custom reference which will be used to thread messages. If you ommit this field, we’ll thread by sender instead
      # metadata.headers      object (optional)  Custom object where any internal information can be stored
      # ----------------------------------------------------
      def receive_custom_message(channel_id, params)
        cleaned = params.permit({ sender: [:contact_id, :name, :handle] },
                                :subject,
                                :body,
                                :body_format,
                                { metadata: [:thread_ref, :headers] })
        create("/channels/#{channel_id}/incoming_messages", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # -----------------------------
      # inbox_id  string  Id of the inbox into which the message should be append.
      # -----------------------------
      #
      # Allowed attributes:
      # Name                        Type                Description
      # -----------------------------------------------------------
      # sender                      object
      # sender.handle               string              Handle used to reach the contact. Can be an email address, a twitter, handle, a phone number, …
      # sender.name                 string (optional)   Name of the contact.
      # sender.author_id            string (optional)   Id of the teammate who is the author of the message. Ignored if the message is inbound.
      # to                          array               List of recipient handles who received the message.
      # cc                          array (optional)    List of recipient handles who received a copy of the message.
      # bcc                         array (optional)    List of the recipeient handles who received a blind copy of the message.
      # subject                     string (optional)   Subject of the message.
      # body                        string              Body of the message.
      # body_format                 enum (optional)     Format of the message body. Ignored if the message type is not email. (Default: 'markdown')
      # external_id                 string              External identifier of the message. Front won’t import two messages with the same external ID.
      # created_at                  number              Date at which the message as been sent or received.
      # type                        enum (optional)     Type of the message to import. (Default: 'email')
      # assignee_id                 string (optional)   Id of the teammate who will be assigned to the conversation.
      # tags                        array (optional)    List of tag names to add to the conversation (unknown tags will automatically be created).
      # metadata                    object
      # metadata.thread_ref         string (optional)   Custom reference which will be used to thread messages. If you ommit this field, we’ll thread by sender instead.
      # metadata.is_inbound         boolean             Whether or not the message is received (inbound) or sent (outbound) by you.
      # metadata.is_archived        boolean (optional)  Whether or not the message should be directly archived once imported. (Default: true)
      # metadata.should_skip_rules  boolean (optional)  Whether or not the rules should apply to this message. (Default: true)
      # -----------------------------------------------------------
      def import_message(inbox_id, params)
        cleaned = params.permit({ sender: [:handle, :name, :author_id] },
                                :to,
                                :cc,
                                :bcc,
                                :subject,
                                :body,
                                :body_format,
                                :external_id,
                                :created_at,
                                :type,
                                :assignee_id,
                                :tags,
                                { metadata: [:thread_ref, :is_inbound, :is_archived, :should_skip_rules] })
        create("/inboxes/#{inbox_id}/imported_messages", cleaned)
      end
    end
  end
end
