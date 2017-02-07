require 'spec_helper'
require 'frontapp'

RSpec.describe 'Tags' do
  let(:frontapp) { Frontapp::Client.new(auth_token: "") }

  let(:all_tags_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/tags"
  },
  "_results": [
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
  ]
}
    }
  }

  let(:get_tag_response) {
    %Q{
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
    }
  }

  let(:create_tag_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/tags/tag_55c8c149",
    "related": {
      "conversations": "https://api2.frontapp.com/tags/tag_55c8c149/conversations"
    }
  },
  "id": "tag_55c8c149",
  "name": "New tag name"
}
    }
  }

  let(:tag_conversations_response) {
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/tags/tag_55c8c149/conversations"
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

  it "can get all tags" do
    stub_request(:get, "https://api2.frontapp.com/tags").
      with( headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 200, body: all_tags_response)
    frontapp.tags
  end

  it "can get a tag" do
    stub_request(:get, "https://api2.frontapp.com/tags/tag_55c8c149").
      with( headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 200, body: get_tag_response)
    frontapp.get_tag("tag_55c8c149")
  end

  it "can create a tag" do
    stub_request(:post, "https://api2.frontapp.com/tags").
      with( body: %q{{"name":"New tag name"}},
            headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 201, body: create_tag_response)
    frontapp.create_tag!({name: "New tag name"})
  end

  it "can get all tag conversations" do
    stub_request(:get, "https://api2.frontapp.com/tags/tag_55c8c149/conversations").
      with( headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 200, body: tag_conversations_response)
    frontapp.get_tag_conversations("tag_55c8c149")
  end
end