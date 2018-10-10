require 'spec_helper'
require 'frontapp'

RSpec.describe 'Contacts' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:contact_id) { "ctc_55c8c149" }
  let(:all_contacts_response) {
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "#{base_url}/contacts"
  },
  "_results": [
    {
      "_links": {
        "self": "#{base_url}/contacts/ctc_55c8c149",
        "related": {
          "notes": "#{base_url}/contacts/ctc_55c8c149/notes",
          "conversations": "#{base_url}/contacts/ctc_55c8c149/conversations"
        }
      },
      "id": "ctc_55c8c149",
      "name": "Calculon",
      "description": "#vip #robot #RIP",
      "avatar_url": "http://example.com/calculon.jpg",
      "is_spammer": true,
      "links": [
        "http://example.com"
      ],
      "handles": [
        {
          "handle": "@calculon",
          "source": "twitter"
        }
      ],
      "groups": [
        {
          "_links": {
            "self": "#{base_url}/contacts/grp_55c8c149",
            "related": {
              "contacts": "#{base_url}/contact_groups/grp_55c8c149/contacts"
            }
          },
          "id": "grp_55c8c149",
          "name": "Customers"
        }
      ]
    }
  ]
}
    }
  }
  let(:get_contact_response) {
    %Q{
{
  "_links": {
    "self": "#{base_url}/contacts/ctc_55c8c149",
    "related": {
      "notes": "#{base_url}/contacts/ctc_55c8c149/notes",
      "conversations": "#{base_url}/contacts/ctc_55c8c149/conversations"
    }
  },
  "id": "ctc_55c8c149",
  "name": "Calculon",
  "description": "#vip #robot #RIP",
  "avatar_url": "http://example.com/calculon.jpg",
  "is_spammer": true,
  "links": [
    "http://example.com"
  ],
  "handles": [
    {
      "handle": "@calculon",
      "source": "twitter"
    }
  ],
  "groups": [
    {
      "_links": {
        "self": "#{base_url}/contacts/grp_55c8c149",
        "related": {
          "contacts": "#{base_url}/contact_groups/grp_55c8c149/contacts"
        }
      },
      "id": "grp_55c8c149",
      "name": "Customers"
    }
  ]
}
    }
  }
  let(:create_contact_response) {
    %Q{
{
  "_links": {
    "self": "#{base_url}/contacts/ctc_55c8c149",
    "related": {
      "notes": "#{base_url}/contacts/ctc_55c8c149/notes",
      "conversations": "#{base_url}/contacts/ctc_55c8c149/conversations"
    }
  },
  "id": "ctc_55c8c149",
  "name": "Calculon",
  "description": "#vip #robot #RIP",
  "avatar_url": "http://example.com/calculon.jpg",
  "is_spammer": true,
  "links": [
    "http://example.com"
  ],
  "handles": [
    {
      "handle": "@calculon",
      "source": "twitter"
    }
  ],
  "groups": [
    {
      "_links": {
        "self": "#{base_url}/contacts/grp_55c8c149",
        "related": {
          "contacts": "#{base_url}/contact_groups/grp_55c8c149/contacts"
        }
      },
      "id": "grp_55c8c149",
      "name": "Customers"
    }
  ],
  "custom_fields": {
    "job title": "engineer"
  }
}
    }
  }
  let(:get_contact_conversations_response) {
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "#{base_url}/contacts/ctc_55c8c149/conversations"
  },
  "_results": [
    {
      "_links": {
        "self": "#{base_url}/conversations/cnv_55c8c149",
        "related": {
          "events": "#{base_url}/conversations/cnv_55c8c149/events",
          "followers": "#{base_url}/conversations/cnv_55c8c149/followers",
          "messages": "#{base_url}/conversations/cnv_55c8c149/messages",
          "comments": "#{base_url}/conversations/cnv_55c8c149/comments",
          "inboxes": "#{base_url}/conversations/cnv_55c8c149/inboxes"
        }
      },
      "id": "cnv_55c8c149",
      "subject": "You broke my heart, Hubert.",
      "status": "archived",
      "assignee": {
        "_links": {
          "self": "#{base_url}/teammates/tea_55c8c149",
          "related": {
            "inboxes": "#{base_url}/teammates/tea_55c8c149/inboxes",
            "conversations": "#{base_url}/teammates/tea_55c8c149/conversations"
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
            "contact": "#{base_url}/contacts/ctc_55c8c149"
          }
        },
        "handle": "calculon@momsbot.com",
        "role": "to"
      },
      "tags": [
        {
          "_links": {
            "self": "#{base_url}/tags/tag_55c8c149",
            "related": {
              "conversations": "#{base_url}/tags/tag_55c8c149/conversations"
            }
          },
          "id": "tag_55c8c149",
          "name": "Robots"
        }
      ],
      "last_message": {
        "_links": {
          "self": "#{base_url}/messages/msg_55c8c149",
          "related": {
            "conversation": "#{base_url}/conversations/cnv_55c8c149",
            "message_replied_to": "#{base_url}/messages/msg_1ab23cd4"
          }
        },
        "id": "msg_55c8c149",
        "type": "email",
        "is_inbound": true,
        "created_at": 1453770984.123,
        "blurb": "Anything less than immortality is a...",
        "author": {
          "_links": {
            "self": "#{base_url}/teammates/tea_55c8c149",
            "related": {
              "inboxes": "#{base_url}/teammates/tea_55c8c149/inboxes",
              "conversations": "#{base_url}/teammates/tea_55c8c149/conversations"
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
                "contact": "#{base_url}/contacts/ctc_55c8c149"
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
            "url": "#{base_url}/download/fil_55c8c149",
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
  let(:get_contact_notes_response) {
    %Q{
{
  "_links": {
    "self": "#{base_url}/contacts/ctc_55c8c149/notes"
  },
  "_results": [
    {
      "author": {
        "_links": {
          "self": "#{base_url}/teammates/tea_55c8c149",
          "related": {
            "inboxes": "#{base_url}/teammates/tea_55c8c149/inboxes",
            "conversations": "#{base_url}/teammates/tea_55c8c149/conversations"
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
      "body": "Calculon is a celebrated actor",
      "created_at": 1453770984.123
    }
  ]
}
    }
  }
  let(:add_contact_note_response) {
    %Q{
{
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
  "body": "Calculon is a celebrated actor",
  "created_at": 1453770984.123
}
    }
  }

  it "can get all contacts" do
    stub_request(:get, "#{base_url}/contacts").
      with( headers: headers).
      to_return(status: 200, body: all_contacts_response)
    frontapp.contacts
  end

  it "can get a specific contact" do
    stub_request(:get, "#{base_url}/contacts/#{contact_id}").
      with( headers: headers).
      to_return(status: 200, body: get_contact_response)
      frontapp.get_contact(contact_id)
  end

  it "can update a contact" do
    data = {
      name: "Calculon",
      description: "#vip #robot #RIP",
      avatar_url: "http://example.com/calculon.jpg",
      is_spammer: true,
      links: [
        "http://example.com"
      ],
      group_names: [ "Customers" ],
      custom_fields: {
        "job title": "engineer"
      }
    }
    stub_request(:patch, "#{base_url}/contacts/#{contact_id}").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 204)
      frontapp.update_contact!(contact_id, data)
  end

  it "can create a contact" do
    data = {
      name: "Calculon",
      description: "#vip #robot #RIP",
      avatar_url: "http://example.com/calculon.jpg",
      is_spammer: true,
      links: [
        "http://example.com"
      ],
      group_names: [ "Customers" ],
      handles: [
        {
          handle: "@calculon",
          source: "twitter"
        }
      ],
      custom_fields: {
        "job title": "engineer"
      }
    }
    stub_request(:post, "#{base_url}/contacts").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: create_contact_response)
    frontapp.create_contact!(data)
  end

  it "can delete a contact" do
    stub_request(:delete, "#{base_url}/contacts/#{contact_id}").
      with( headers: headers).
      to_return(status: 204)
    frontapp.delete_contact!(contact_id)
  end

  it "can get all contact's conversations" do
    stub_request(:get, "#{base_url}/contacts/#{contact_id}/conversations").
      with( headers: headers).
      to_return(status: 200, body: get_contact_conversations_response)
    frontapp.get_contact_conversations(contact_id)
  end

  it "can add a handle to a contact" do
    data = {
      handle: "@calculon",
      source: "twitter"
    }
    stub_request(:post, "#{base_url}/contacts/#{contact_id}/handles").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 204)
    frontapp.add_contact_handle!(contact_id, data)
  end

  it "can delete a handle of a contact" do
    data = {
      handle: "@calculon",
      source: "twitter"
    }
    stub_request(:delete, "#{base_url}/contacts/#{contact_id}/handles").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 204)
    frontapp.delete_contact_handle!(contact_id, data)
  end

  it "can get all notes for a contact" do
    stub_request(:get, "#{base_url}/contacts/#{contact_id}/notes").
      with( headers: headers).
      to_return(status: 200, body: get_contact_notes_response)
    frontapp.get_contact_notes(contact_id)
  end

  it "can add a note to a contact" do
    data = {
      author_id: "alt:email:leela@planet-express.com",
      body: "Calculon is a celebrated actor"
    }
    stub_request(:post,"#{base_url}/contacts/#{contact_id}/notes").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: add_contact_note_response)
    frontapp.add_contact_note!(contact_id, data)
  end
end
