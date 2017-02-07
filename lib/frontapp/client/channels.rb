module Frontapp
  class Client
    module Channels

      def channels(params = {})
        list("channels", params)
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # channel_id  string  Id of the requested channel
      # -------------------------------
      def get_channel(channel_id)
        get("channels/#{channel_id}")
      end

      # Only custom channels can be updated through the api!
      #
      # Parameters
      # Name        Type    Description
      # -------------------------------
      # channel_id  string  Id of the requested channel
      # -------------------------------
      #
      # Allowed attributes:
      # Name                  Type              Description
      # ---------------------------------------------------
      # settings              object
      # settings.webhook_url  string (optional) custom type only. URL to which will be sent the replies of a custom message.
      # ---------------------------------------------------
      def update_channel!(channel_id, params = {})
        cleaned = params.permit({ settings: [:webhook_url] })
        update("channels/#{channel_id}", cleaned)
      end

      # Only custom channels can be created through the api!
      #
      # Parameters
      # Name      Type    Description
      # -----------------------------
      # inbox_id  string  Id of the inbox into which the channel messages will go
      # -----------------------------
      #
      # Allowed attributes:
      # Name                  Type               Description
      # ----------------------------------------------------
      # type                  enum               Type of the channel.
      # settings              object
      # settings.webhook_url  string (optional)  custom type only. URL to which will be sent the replies of a custom message.
      # ----------------------------------------------------
      def create_channel!(inbox_id, params = {})
        cleaned = params.permit(:type, { settings: [:webhook_url] })
        create("inboxes/#{inbox_id}/channels", cleaned)
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # channel_id  string  Id of the requested channel
      # -------------------------------
      def get_channel_inbox(channel_id)
        get("channels/#{channel_id}/inbox")
      end

    end
  end
end