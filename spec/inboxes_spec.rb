require 'spec_helper'
require 'frontapp'

RSpec.describe 'Contact' do

  let(:headers) {
    {
      'Accept' => "application/json",

      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:inbox_id) { "inb_55c8c149" }
  let(:all_inboxes_response){
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/inboxes"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/inboxes/inb_55c8c149",
        "related": {
          "teammates": "https://api2.frontapp.com/inboxes/inb_55c8c149/teammates",
          "conversations": "https://api2.frontapp.com/inboxes/inb_55c8c149/conversations",
          "channels": "https://api2.frontapp.com/inboxes/inb_55c8c149/channels"
        }
      },
      "id": "inb_55c8c149",
      "address": "team@planet-express.com",
      "type": "smtp",
      "name": "Team",
      "send_as": "team@planet-express.com"
    }
  ]
}
    }
  }
  let(:get_inbox_response){
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/inboxes/inb_55c8c149",
    "related": {
      "teammates": "https://api2.frontapp.com/inboxes/inb_55c8c149/teammates",
      "conversations": "https://api2.frontapp.com/inboxes/inb_55c8c149/conversations",
      "channels": "https://api2.frontapp.com/inboxes/inb_55c8c149/channels"
    }
  },
  "id": "inb_55c8c149",
  "address": "team@planet-express.com",
  "type": "smtp",
  "name": "Team",
  "send_as": "team@planet-express.com"
}
    }
  }
  let(:create_inbox_response){
    %Q{
{
  "id": "inb_55c8c149",
  "name": "Delivery support"
}
    }
  }
  let(:get_inbox_channels_response){
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/inboxes/inb_55c8c149/channels"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/channels/cha_55c8c149",
        "related": {
          "inbox": "https://api2.frontapp.com/channels/cha_55c8c149/inbox"
        }
      },
      "id": "cha_55c8c149",
      "address": "team@planet-express.com",
      "type": "smtp",
      "send_as": "team@planet-express.com",
      "settings": {}
    }
  ]
}
    }
  }
  let(:get_inbox_conversations_response){
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/inboxes/inb_55c8c149/conversations"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/conversations/cnv_55c8c149",
        "related": {
          "events": "https://api2.frontapp.com/conversations/cnv_55c8c149/events",
          "followers": "https://api2.frontapp.com/conversations/cnv_55c8c149/followers",
          "messages": "https://api2.frontapp.com/conversations/cnv_55c8c149/messages",
          "comments": "https://api2.frontapp.com/conversations/cnv_55c8c149/comments",
          "inboxes": "https://api2.frontapp.com/conversations/cnv_55c8c149/inboxes"
        }
      },
      "id": "cnv_55c8c149",
      "subject": "You broke my heart, Hubert.",
      "status": "archived",
      "assignee": {
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
      "recipient": {
        "_links": {
          "related": {
            "contact": "https://api2.frontapp.com/contacts/ctc_55c8c149"
          }
        },
        "handle": "calculon@momsbot.com",
        "role": "to"
      },
      "tags": [
        {
          "_links": {
            "self": "https://api2.frontapp.com/tags/tag_55c8c149",
            "related": {
              "conversations": "https://api2.frontapp.com/tags/tag_55c8c149/conversations"
            }
          },
          "id": "tag_55c8c149",
          "name": "Robots"
        }
      ],
      "last_message": {
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
      },
      "created_at": 1453770984.123
    }
  ]
}
    }
  }
  let(:get_inbox_teammates_response){
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/inboxes/inb_55c8c149/teammates"
  },
  "_results": [
    {
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
    }
  ]
}
    }
  }

  it "can get all inboxes" do
    stub_request(:get, "#{base_url}/inboxes").
      with( headers: headers).
      to_return(status: 200, body: all_inboxes_response)
    frontapp.inboxes
  end

  it "can get a specific inbox" do
    stub_request(:get, "#{base_url}/inboxes/#{inbox_id}").
      with( headers: headers).
      to_return(status: 200, body: get_inbox_response)
    frontapp.get_inbox(inbox_id)
  end

  it "can create an inbox" do
    data = {
      name: "Delivery support",
      teammate_ids: []
    }
    stub_request(:post, "#{base_url}/inboxes").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: create_inbox_response)
    frontapp.create_inbox!(data)
  end

  it "can get all channels for an inbox" do
    stub_request(:get, "#{base_url}/inboxes/#{inbox_id}/channels").
      with( headers: headers).
      to_return(status: 200, body: get_inbox_channels_response)
    frontapp.get_inbox_channels(inbox_id)
  end

  it "can get all conversations in an inbox" do
    stub_request(:get, "#{base_url}/inboxes/#{inbox_id}/conversations").
      with( headers: headers).
      to_return(status: 200, body: get_inbox_conversations_response)
    frontapp.get_inbox_conversations(inbox_id)
  end

  it "can get all teammates that can access an inbox" do
    stub_request(:get, "#{base_url}/inboxes/#{inbox_id}/teammates").
      with( headers: headers).
      to_return(status: 200, body: get_inbox_teammates_response)
    frontapp.get_inbox_teammates(inbox_id)
  end
end