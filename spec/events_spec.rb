require 'spec_helper'
require 'frontapp'

RSpec.describe 'Events' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:event_id) { "evt_55c8c149" }
  let(:all_events_response) {
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/events"
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
  let(:get_event_response) {
    %Q{
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
    }
  }

  it "can get all events" do
    stub_request(:get, "#{base_url}/events").
      with( headers: headers).
      to_return(status: 200, body: all_events_response)
    frontapp.events
  end

  it "can get a specific event" do
    stub_request(:get, "#{base_url}/events/#{event_id}").
      with( headers: headers).
      to_return(status: 200, body: get_event_response)
    frontapp.get_event(event_id)
  end

end