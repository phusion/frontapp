module Frontapp
  class Client
    module Drafts
      # See https://dev.frontapp.com/reference/create-draft-reply
      def create_draft_reply(conversation_id, params)
        # ordered in the same order as the API documentation
        cleaned_params = params.permit(
          :author_id,
          :to,
          :cc,
          :bcc,
          :subject,
          :body,
          :quote_body,
          :attachments,
          {
            options: [:tags, :archive],
          },
          :mode,
          :signature_id,
          :should_add_default_signature,
          :channel_id,
        )
        create("conversations/#{conversation_id}/drafts", cleaned_params)
      end
    end
  end
end
