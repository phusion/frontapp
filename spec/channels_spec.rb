require 'spec_helper'
require 'frontapp'

RSpec.describe 'Channels' do
  let(:frontapp) { Frontapp::Client.new(auth_token: "") }

  let(:all_channels_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/channels"
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

  let(:get_channel_response) {
    %Q{
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
    }
  }

  let(:create_channel_response) {
    %Q{
{
  "id": "cha_55c8c149",
  "type": "custom",
  "address": "dw0a0b7aeg36cb56",
  "sendAs": "dw0a0b7aeg36cb56",
  "settings": {
    "webhook_url": "http://example.com"
  }
}
    }
  }

  let(:channel_inbox_response) {
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

  it "can get all channels" do
    stub_request(:get, "https://api2.frontapp.com/channels").
      with( headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 200, body: all_channels_response)
    frontapp.channels
  end

  it "can get a channel" do
    stub_request(:get, "https://api2.frontapp.com/channels/cha_55c8c149").
      with( headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 200, body: get_channel_response)
    frontapp.get_channel("cha_55c8c149")
  end

  it "can update a channel" do
    stub_request(:patch, "https://api2.frontapp.com/channels/cha_55c8c149").
      with( body: %q{{"settings":{"webhook_url":"/fooo"}}},
            headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 204)
    frontapp.update_channel!("cha_55c8c149", { settings: { webhook_url: "/fooo" } })
  end

  it "can create a channel" do
    stub_request(:post, "https://api2.frontapp.com/inboxes/inb_55c8c149/channels").
      with( body: %q{{"type":"custom","settings":{"webhook_url":"/uri"}}},
            headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 201, body: create_channel_response)
    frontapp.create_channel!("inb_55c8c149", { type: "custom", settings: { webhook_url: "/uri" } })
  end

  it "can get channel inbox" do
    stub_request(:get, "https://api2.frontapp.com/channels/cha_55c8c149/inbox").
      with( headers: {
              'Accept'=>'application/json',
              'Authorization'=>'Bearer ',
            }).
      to_return(status: 200, body: channel_inbox_response)
    frontapp.get_channel_inbox("cha_55c8c149")
  end
end