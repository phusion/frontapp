module Frontapp
  class Client
    module Attachments

      # Parameters
      # Name                Type    Description
      # ----------------------------------------------------------
      # attachment_link_id  string  Id of the requested attachment
      # ----------------------------------------------------------
      def download_attachment(attachment_link_id)
        get_raw("download/#{attachment_link_id}")
      end
    end
  end
end
