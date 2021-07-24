require 'spec_helper'
require 'frontapp'

RSpec.describe 'Topics' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:topic_id) { "top_55c8c149" }
  let(:topic_conversations_response) {
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/topics/top_55c8c149/conversations"
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
            "contact": "https://api2.frontapp.com/contacts/crd_55c8c149"
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
              "conversations": "https://api2.frontapp.com/tags/tag_55c8c149/conversations",
              "owner": "https://api2.frontapp.com/teams/tim_55c8c149"
            }
          },
          "id": "tag_55c8c149",
          "name": "Robots",
          "is_private": false
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
          "is_available": true
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
      },
      "created_at": 1453770984.123,
      "is_private": false
    }
  ]
}
    }
  }
  let(:topics_response) do
    %Q{
{
  "_pagination": {
    "next": null
  },
  "_links": {
    "self": "https://api2.frontapp.com/topics?"
  },
  "_results": [
    {
      "id": "top_55c8c149",
      "name": "123456",
      "type": "web",
      "link": "https://example.com/something/123456"
    },
    {
      "id": "top_55ih5t",
      "name": "www.google.com",
      "type": "web",
      "link": "www.google.com"
    },
    {
      "id": "top_55i8f5",
      "name": "something.io",
      "type": "web",
      "link": "http://something.io"
    }
  ]
}
    }
  end
  let(:get_topic_response) do
    %Q{
{
  "id": "top_55c8c149",
  "name": "123456",
  "type": "web",
  "link": "https://example.com/something/123456"
}
    }
  end
  let(:create_topic_response) {
    %Q{
{
  "id": "top_3ij8h",
  "name": "Bla",
  "type": "web",
  "link": "bla.io"
}
    }
  end

  it "can get all topic conversations" do
    stub_request(:get, "#{base_url}/topics/#{topic_id}/conversations").
      with( headers: headers).
      to_return(status: 200, body: topic_conversations_response)
    frontapp.get_topic_conversations(topic_id)
  end

  it "can list topics" do
    stub_request(:get, "#{base_url}/topics").
      with( headers: headers).
      to_return(status: 200, body: topics_response)
    frontapp.topics
  end

  it "can get a topic" do
    stub_request(:get, "#{base_url}/topics/#{topic_id}").
      with( headers: headers).
      to_return(status: 200, body: get_topic_response)
    frontapp.get_topic(topic_id)
  end

  it "can create a topic" do
    data = {
      name: "New topic",
      link: "my.link"
    }
    stub_request(:post, "#{base_url}/topics").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 200, body: )
  end

  it "can update a topic" do
    data = {
      name: "new name"
    }
    stub_request(:patch, "#{base_url}/topics/#{topic_id}").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 204)
    frontapp.update_topic!(topic_id, data)
  end
end
