require 'spec_helper'
require 'frontapp'

RSpec.describe 'Drafts' do
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:conversation_id) { 'cnv_55c8c149' }

  # see https://dev.frontapp.com/reference/drafts
  let(:create_draft_reply_response) do
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/messages/msg_55c8c149",
    "related": {
      "conversation": "https://api2.frontapp.com/conversations/cnv_55c8c149",
      "message_replied_to": "https://api2.frontapp.com/messages/msg_1ab23cd4"
    }
  },
  "id": "msg_55c8c149",
  "type": "email",
  "is_inbound": true,
  "is_draft": false,
  "created_at": 1453770984.123,
  "blurb": "Anything less than immortality is a...",
  "author": {
    "_links": {
      "self": "https://api2.frontapp.com/teammates/tea_55c8c149",
      "related": {
        "inboxes": "https://api2.frontapp.com/teammates/tea_55c8c149/inboxes",
        "conversations": "https://api2.frontapp.com/teammates/tea_55c8c149/conversations"
      }
    },
    "id": "tea_55c8c149",
    "email": "leela@planet-express.com",
    "username": "leela",
    "first_name": "Leela",
    "last_name": "Turanga",
    "is_admin": true,
    "is_available": true,
    "is_blocked": false
  },
  "recipients": [
    {
      "_links": {
        "related": {
          "contact": "https://api2.frontapp.com/contacts/crd_55c8c149"
        }
      },
      "handle": "calculon@momsbot.com",
      "role": "to"
    }
  ],
  "body": "Anything less than immortality is a complete waste of time.",
  "text": "Anything less than immortality is a complete waste of time.",
  "attachments": [
    {
      "filename": "attachment.jpg",
      "url": "https://api2.frontapp.com/download/fil_55c8c149",
      "content_type": "image/jpeg",
      "size": 10000,
      "metadata": {
        "is_inline": true,
        "cid": "123456789"
      }
    }
  ],
  "metadata": {}
}
    }
  end

  describe '#create_draft_reply' do
    it 'creates a draft valid' do
      body = {
        author_id: 'alt:email:leela@planet-exress.com',
        body: 'Why is Zoidberg the only one still alone?',
        to: ['calculon@momsbot.com'],
      }

      stub_request(:post, "#{base_url}/conversations/#{conversation_id}/drafts")
        .with(body: body, headers: standard_headers)
        .to_return(status: 200, body: create_draft_reply_response)

      response = frontapp.create_draft_reply(conversation_id, body)

      expect(response).to eq(JSON.parse(create_draft_reply_response))
    end
  end
end
