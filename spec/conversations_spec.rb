require 'spec_helper'
require 'frontapp'

RSpec.describe 'Conversations' do

  let(:headers) { json_headers }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:conversation_id) { "cnv_55c8c149" }
  let(:all_conversations_response) {
    %{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/conversations"
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
  let(:get_conversation_response) {
    %{
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
    }
  }
  let(:get_conversation_inboxes_response) {
    %{
{
  "_links": {
    "self": "https://api2.frontapp.com/conversations/cnv_55c8c149/inboxes"
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
  let(:get_conversation_followers_response) {
    %{
{
  "_links": {
    "self": "https://api2.frontapp.com/conversations/cnv_55c8c149/followers"
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
  let(:get_conversation_events_response) {
    %{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/conversations/cnv_55c8c149/events"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/events/evt_55c8c149"
      },
      "id": "evt_55c8c149",
      "type": "assign",
      "emitted_at": 1453770984.123,
      "source": {
        "_meta": {
          "type": "rule"
        },
        "data": {
          "_links": {
            "self": "https://api2.frontapp.com/rules/rul_55c8c149"
          },
          "id": "rul_55c8c149",
          "name": "Important deliveries",
          "actions": [
            "Assign to Leela Turanga"
          ]
        }
      },
      "target": {
        "_meta": {
          "type": "teammate"
        },
        "data": {
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
      },
      "conversation": {
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
    }
  ]
}
    }
  }
  let(:get_conversation_messages_response) {
    %{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/conversations/cnv_55c8c149/messages"
  },
  "_results": [
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
  ]
}
    }
  }


  it "can list all conversations" do
    stub_request(:get, "#{base_url}/conversations").
      with( headers: headers).
      to_return(status: 200, body: all_conversations_response)
    frontapp.conversations
  end

  it "can search conversations" do
    stub_request(:get, "#{base_url}/conversations/search/#{
      CGI.escape("\"foo bar\" buzz status:archived").gsub("+", "%20")
    }").
      with( headers: headers).
      to_return(status: 200, body: all_conversations_response)
    frontapp.conversations_search(
      search_phrases: ["foo bar", "buzz"],
      search_params: { status: "archived" }
    )
  end

  it "can get a specific conversation" do
    stub_request(:get, "#{base_url}/conversations/#{conversation_id}").
      with( headers: headers).
      to_return(status: 200, body: get_conversation_response)
    frontapp.get_conversation(conversation_id)
  end

  it "can update a conversation" do
    data = {
      assignee_id: "alt:email:fry@planet-express.com",
      inbox_id: "inb_55c8c149",
      status: "archived",
      tags: [ "time travel" ]
    }
    stub_request(:patch, "#{base_url}/conversations/#{conversation_id}").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 204)
    frontapp.update_conversation!(conversation_id, data)
  end

  it "can get all the inboxes a conversation is in" do
    stub_request(:get, "#{base_url}/conversations/#{conversation_id}/inboxes").
      with( headers: headers).
      to_return(status: 200, body: get_conversation_inboxes_response)
    frontapp.get_conversation_inboxes(conversation_id)
  end

  it "can get all the followers of a conversation" do
    stub_request(:get, "#{base_url}/conversations/#{conversation_id}/followers").
      with( headers: headers).
      to_return(status: 200, body: get_conversation_followers_response)
    frontapp.get_conversation_followers(conversation_id)
  end

  it "can get all events for a conversation" do
    stub_request(:get, "#{base_url}/conversations/#{conversation_id}/events").
      with( headers: headers).
      to_return(status: 200, body: get_conversation_events_response)
    frontapp.get_conversation_events(conversation_id)
  end

  it "can get all messages in a conversation" do
    stub_request(:get, "#{base_url}/conversations/#{conversation_id}/messages").
      with( headers: headers).
      to_return(status: 200, body: get_conversation_messages_response)
    frontapp.get_conversation_messages(conversation_id)
  end

  it "can add conversation links by id" do
    data = {
      link_ids: ["top_55c8c149"]
    }
    stub_request(:post, "#{base_url}/conversations/#{conversation_id}/links").
      with( headers: headers).
      to_return(status: 202)
    frontapp.add_conversation_links!(conversation_id, data)
  end

  it "can add conversation links by link external url" do
    data = {
      link_external_urls: ["example.com/my-link"]
    }
    stub_request(:post, "#{base_url}/conversations/#{conversation_id}/links").
      with( headers: headers).
      to_return(status: 202)
    frontapp.add_conversation_links!(conversation_id, data)
  end

  xit "can remove conversation links by id" do
    data = {
      link_ids: ["top_55c8c149"]
    }
    stub_request(:delete, "#{base_url}/conversations/#{conversation_id}/links").
      with( headers: headers).
      to_return(status: 204, body: nil)
    frontapp.delete_tag!(conversation_id, data)
  end

  it "can remove conversation followers by id" do
    data = {
      teammate_ids: ["tea_64ue9"]
    }
    stub_request(:delete, "#{base_url}/conversations/#{conversation_id}/followers").
      with( headers: headers).
      to_return(status: 204, body: nil)
    frontapp.remove_conversation_followers!(conversation_id, data)
  end

  it "can add conversation followers by id" do
    data = {
      link_ids: ["tea_64ue9"]
    }
    stub_request(:post, "#{base_url}/conversations/#{conversation_id}/followers").
      with( headers: headers).
      to_return(status: 202)
    frontapp.add_conversation_followers!(conversation_id, data)
  end
end
