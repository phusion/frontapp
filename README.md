# Frontapp

Ruby client to work with Frontapp API (https://dev.frontapp.com)

## Installation

```Bash
gem install frontapp
```

## Usage

The auth_token can be obtained from Frontapp, in Settings -> API & Integrations -> API

Create a Frontapp client
```ruby
require 'frontapp'
client = Frontapp::Client.new(auth_token: 'token') 
```

### Channels
```ruby
# Get all channels
channels = client.channels

# Get a specific channel
channel = client.get_channel("cha_55c8c149")

# Update the webhook url of a custom channel
client.update_channel!("cha_55c8c149", { settings: { webhook_url: "my-uri" } })

# Create custom channel
channel = client.create_channel!("inb_55c8c149",  { settings: { webhook_url: "my-uri" } })

# Get the inbox for a channel
inbox = client.get_channel_inbox("cha_55c8c149")

```

### Comments
```ruby
# Create a new comment in a conversation
comment = client.create_comment!("cnv_55c8c149", { author_id: "user@example.com", body: "text" })

# Get all comments for a conversation
comments = client.get_conversation_comments("cnv_55c8c149")

# Get a specific comment
comment = client.get_comment("com_55c8c149")

# Get all mentions in a comment
mentions = client.get_comment_mentions("com_55c8c149")
```

### Contact Groups
```ruby
# Get all contact groups
group = client.contact_groups

# Create a new contact group
group = client.create_contact_group!({ name: "Name" })

# Delete a contact group
client.delete_contact_group!("grp_55c8c149")

# Get all contacts in a group
contacts = client.get_contact_group_contacts("grp_55c8c149")

# Add contacts to a group
client.add_contacts_to_contact_group!("grp_55c8c149", { contact_ids: ["name@example.com", "other@example.com"] })

```

### Contacts
```ruby
# Get all contacts
contacts = client.contacts

# Get a specific contact
contact = client.get_contact("ctc_55c8c149")

# Update a contact
client.update_contact!("ctc_55c8c149", {
	name: "Name",
	description: "Description",
	avatar_url: "http://example.com/avatar",
	is_spammer: false,
	links: ["http://example.com"],
	group_names: ["Customer"]
})

# Create a new contact
contact = client.create_contact!("ctc_55c8c149", {
	name: "Name",
	description: "Description",
	avatar_url: "http://example.com/avatar",
	is_spammer: false,
	links: ["http://example.com"],
	group_names: ["Customer"]
	handles: [{
      "handle": "@calculon",
      "source": "twitter"
    }]
})

# Delete a contact
client.delete_contact!("ctc_55c8c149")

# Get all conversations for a contact
# Optionally include a filter for conversation statuses
conversations = client.get_contact_conversations("ctc_55c8c149", { q: { statuses: ["assigned", "unassigned"] } })

# Add a handle to a contact
client.add_contact_handle!("ctc_55c8c149", { handle: "@calculon", source: "twitter" })

# Delete a handle from a contact
client.delete_contact_handle!("ctc_55c8c149", { handle: "@calculon", source: "twitter" })

# Get all notes for a contact
notes = client.get_contact_notes("ctc_55c8c149")

# Create a new note for a contact
note = client.add_contact_note!("ctc_55c8c149", {
  author_id: "user@example.com",
  body: "Foobar"
})

```

### Conversations
```ruby
# Get all conversations
conversations = client.conversations

# Get a specific conversation
converstation = client.get_conversation("cnv_55c8c149")

# Update a conversation
client.update_conversation!("cnv_55c8c149", {
  assignee_id: "user@example.com",
  status: "archived",
  tags: ["time travel"]
})

# Get all inboxes a conversation is in
inboxes = client.get_conversation_inboxes("cnv_55c8c149")

# Get all teammates following a conversation
followers = client.get_conversation_followers("cnv_55c8c149")

# Get all events for a conversation
events = client.get_conversation_events("cnv_55c8c149")

# Get all messages for a conversation
messages = client.get_conversation_messages("cnv_55c8c149")

```

### Events
```ruby
# Get all events
events = client.events

# Get a specific event
event = client.get_event("evt_55c8c149")

```

### Inboxes
```ruby
# Get all inboxes
inboxes = client.inboxes

# Get a specific inbox
inbox = client.get_inbox("inb_55c8c149")

# Create a new inbox
inbox = client.create_inbox!({ name: "Support", teammate_ids: [] })

# Get all channels for an inbox
channels = client.get_inbox_channels("inb_55c8c149")

# Get all conversations in an inbox
# Optionally include a filter for conversation statuses
conversations = client.get_inbox_conversations("inb_55c8c149", { q: { statuses: ["assigned", "unassigned"] } })

# Get all teammates that have access
teammates = client.get_inbox_teammates("inb_55c8c149")

```

### Messages
```ruby
# Get a specific message
message = client.get_message("msg_55c8c149")

# Send a new message to a channel
conversation_reference = client.send_message("cha_55c8c149", {
  author_id: "user@example.com",
  subject: "Good news everyone!",
  body: "Why is Zoidberg the only one still alone?",
  text: "Why is Zoidberg the only one still alone?",
  options: {
    tags: [],
    archive: true
  },
  to: [
    "me@example.com"
  ],
  cc: [],
  bcc: []
})

# Send a reply to a conversation
client.send_reply("cnv_55c8c149", {
  author_id: "user@example.com",
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
})

# Receive a custom message on a channel
conversation_reference = client.receive_custom_message("cha_55c8c149", {
  sender: {
    name: "hermes",
    handle: "hermes_123"
  },
  subject: "Question",
  body: "Didn't we used to be a delivery company?",
  metadata: {}
})

# Import a message in a channel
conversation_reference = client.import_message("cha_55c8c149", {
  sender: {
    handle: "user@example.com"
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
})

```

### Rules
```ruby
# Get all rules
rules = client.rules

# Get a specific rule
rule = client.get_rule("rul_55c8c149")

```

### Tags
```ruby
# Get all tags
tags = client.tags

# Get specific tag
tag = client.get_tag("tag_55c8c149")

# Create tag
tag = client.create_tag!({name: "New tag name"})

# Get all conversation for a tag
# Optionally include a filter for conversation statuses
conversations = client.get_tag_conversations("tag_55c8c149", { q: { statuses: ["assigned", "unassigned"] } })
```

### Teammates
```ruby
# Get all teammates
teammates = client.teammates

# Get a teammate
teammate = client.get_teammate("user@example.com")

# Update a teammate
client.update_teammate!("user@example.com", {
  username: "bender",
  first_name: "Bender",
  last_name: "Rodriguez",
  is_admin: true,
  is_available: false
})

# Get all conversations for a teammate
conversations = client.get_teammate_conversations("user@example.com", { q: { statuses: ["assigned", "unassigned"] } })

# Get all inboxes for a teammate
inboxes = client.get_teammate_inboxes("user@example.com")

```
