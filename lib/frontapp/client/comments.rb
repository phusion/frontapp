module Frontapp
  class Client
    module Comments

      # Parameters
      # Name             Type    Description
      # ------------------------------------
      # conversation_id  string  Id of the requested conversation
      # ------------------------------------
      #
      # Allowed attributes:
      # Name       Type    Description
      # ------------------------------
      # author_id  string  Id of the teammate creating the comment
      # body       string  Content of the comment
      # ------------------------------
      def create_comment!(conversation_id, params = {})
        cleaned = params.permit(:author_id,:body)
        create("conversations/{conversation_id}/comments", cleaned)
      end

      # Parameters
      # Name             Type    Description
      # ------------------------------------
      # conversation_id  string  Id of the requested conversation
      # ------------------------------------
      def get_conversation_comments(conversation_id)
        list("conversations/#{conversation_id}/comments")
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # comment_id  string  Id of the requested comment
      # -------------------------------
      def get_comment(comment_id)
        get("comments/#{comment_id}")
      end

      # Parameters
      # Name        Type    Description
      # -------------------------------
      # comment_id  string  Id of the requested comment
      # -------------------------------
      def get_comment_mentions(comment_id)
        get("comments/#{comment_id}/mentions")
      end

    end
  end
end