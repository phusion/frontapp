require 'spec_helper'
require 'frontapp'

RSpec.describe 'Comments' do

  let(:headers) { json_headers }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:conversation_id) { "cnv_55c8c149" }
  let(:comment_id) { "com_55c8c149" }
  let(:create_comment_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/comments/inb_55c8c149",
    "related": {
      "conversation": "https://api2.frontapp.com/conversations/cnv_55c8c149",
      "mentions": "https://api2.frontapp.com/comments/com_55c8c149/mentions"
    }
  },
  "id": "com_55c8c149",
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
  "body": "@bender, I thought you were supposed to be cooking for this party.",
  "posted_at": 1453770984.123
}
    }
  }
  let(:get_conversation_comments_resonse) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/conversations/cnv_55c8c149/comments"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/comments/inb_55c8c149",
        "related": {
          "conversation": "https://api2.frontapp.com/conversations/cnv_55c8c149",
          "mentions": "https://api2.frontapp.com/comments/com_55c8c149/mentions"
        }
      },
      "id": "com_55c8c149",
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
      "body": "@bender, I thought you were supposed to be cooking for this party.",
      "posted_at": 1453770984.123
    }
  ]
}
    }
  }
  let(:get_comment_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/comments/inb_55c8c149",
    "related": {
      "conversation": "https://api2.frontapp.com/conversations/cnv_55c8c149",
      "mentions": "https://api2.frontapp.com/comments/com_55c8c149/mentions"
    }
  },
  "id": "com_55c8c149",
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
  "body": "@bender, I thought you were supposed to be cooking for this party.",
  "posted_at": 1453770984.123
}
    }
  }
  let(:get_comment_mentions_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/comments/com_55c8c149/mentions"
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

  it "create a comment" do
    data = {
      author_id: "alt:email:leela@planet-express.com",
      body: "@bender, I thought you were supposed to be cooking for this party."
    }
    stub_request(:post, "#{base_url}/conversations/#{conversation_id}/comments").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: create_comment_response)
    frontapp.create_comment!(conversation_id, data)
  end

  it "can get all comments of a conversation" do
    stub_request(:get, "#{base_url}/conversations/#{conversation_id}/comments").
      with( headers: headers).
      to_return(status: 200, body: get_conversation_comments_resonse)
    frontapp.get_conversation_comments(conversation_id)
  end

  it "can get a specific comment" do
    stub_request(:get, "#{base_url}/comments/#{comment_id}").
      with( headers: headers).
      to_return(status: 200, body: get_comment_response)
      frontapp.get_comment(comment_id)
  end

  it "can get all mentions in a comment" do
    stub_request(:get, "#{base_url}/comments/#{comment_id}/mentions").
      with( headers: headers).
      to_return(status: 200, body: get_comment_mentions_response)
      frontapp.get_comment_mentions(comment_id)
  end
end