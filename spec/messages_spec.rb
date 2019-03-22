require 'spec_helper'
require 'frontapp'

RSpec.describe 'Messages' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:message_id) { "msg_55c8c149" }
  let(:channel_id) { "cha_55c8c149" }
  let(:conversation_id) { "cnv_55c8c149" }
  let(:inbox_id) { "inb_55c8c149" }
  let(:get_message_response) {
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
    "is_available": true
  },
  "recipients": [
    {
      "_links": {
        "related": {
          "contact": "https://api2.frontapp.com/contacts/ctc_55c8c149"
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
  }
  let(:message_source) { "Who wants to live forever?" }
  let(:send_message_from_channel_response) {
    %Q{
{
  "conversation_reference": "3b1q41d8@frontapp.com"
}
    }
  }
  let(:receive_custom_message_response) {
    %Q{
{
  "conversation_reference": "3b1q41d8@frontapp.com"
}
    }
  }
  let(:import_message_response) {
    %Q{
{
  "conversation_reference": "3b1q41d8@frontapp.com"
}
    }
  }

  it "can get a specific message" do
    stub_request(:get, "#{base_url}/messages/#{message_id}").
      with( headers: headers).
      to_return(status: 200, body: get_message_response)
    frontapp.get_message(message_id)
  end
  
  it "can get a specific message source" do
    headers['Accept'] = 'text/plain'
    stub_request(:get, "#{base_url}/messages/#{message_id}").
      with( headers: headers).
      to_return(status: 200, body: message_source)
    frontapp.get_message_source(message_id)
  end
  
  it "can send a message from a channel" do
    data = {
      author_id: "alt:email:leela@planet-exress.com",
      sender_name: 'Leela',
      subject: "Good news everyone!",
      body: "Why is Zoidberg the only one still alone?",
      text: "Why is Zoidberg the only one still alone?",
      options: {
        tags: [],
        archive: true
      },
      to: [ "calculon@momsbot.com" ],
      cc: [],
      bcc: []
    }
    stub_request(:post, "#{base_url}/channels/#{channel_id}/messages").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 202, body: send_message_from_channel_response)
    frontapp.send_message(channel_id, data)
  end

  it "can send a reply" do
    data = {
      author_id: "alt:email:leela@planet-exress.com",
      sender_name: 'Leela',
      subject: "Good news everyone!",
      body: "Why is Zoidberg the only one still alone?",
      text: "Why is Zoidberg the only one still alone?",
      options: {
        tags: [],
        archive: true
      },
      channel_id: "cha_55c8c149",
      to: [],
      cc: [],
      bcc: []
    }
    stub_request(:post, "#{base_url}/conversations/#{conversation_id}/messages").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 202)
    frontapp.send_reply(conversation_id, data)
  end

  it "can receive a custom message in a channel" do
    data = {
      sender: {
        name: "hermes",
        handle: "hermes_123"
      },
      subject: "Question",
      body: "Didn't we used to be a delivery company?",
      metadata: {}
    }
    stub_request(:post, "#{base_url}/channels/#{channel_id}/incoming_messages").
    with( body: data.to_json,
              headers: headers).
      to_return(status: 202, body: receive_custom_message_response)
    frontapp.receive_custom_message(channel_id, data)
  end

  it "can import a message into an inbox" do
    data = {
      sender: {
        handle: "calculon@momsbot.com"
      },
      to: [],
      cc: [],
      bcc: [],
      body: "",
      external_id: "",
      created_at: 1453770984.123,
      tags: [],
      metadata: {
        is_inbound: true,
        is_archived: true,
        should_skip_rules: true
      }
    }
    stub_request(:post, "#{base_url}/inboxes/#{inbox_id}/imported_messages").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 202, body: import_message_response)
    frontapp.import_message(inbox_id, data)
  end
end