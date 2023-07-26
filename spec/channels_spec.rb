require 'spec_helper'
require 'frontapp'

RSpec.describe 'Channels' do

  let(:headers) { json_headers }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:channel_id) { "cha_55c8c149" }
  let(:inbox_id) { "inb_55c8c149" }
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
    stub_request(:get, "#{base_url}/channels").
      with( headers: headers).
      to_return(status: 200, body: all_channels_response)
    frontapp.channels
  end

  it "can get a specific channel" do
    stub_request(:get, "#{base_url}/channels/#{channel_id}").
      with( headers: headers).
      to_return(status: 200, body: get_channel_response)
    frontapp.get_channel(channel_id)
  end

  it "can update a channel" do
    data = { settings: { webhook_url: "/fooo" } }
    stub_request(:patch, "#{base_url}/channels/#{channel_id}").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 204)
    frontapp.update_channel!(channel_id, data)
  end

  it "can create a channel" do
    data = { type: "custom", settings: { webhook_url: "/uri" } }
    stub_request(:post, "#{base_url}/inboxes/#{inbox_id}/channels").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: create_channel_response)
    frontapp.create_channel!(inbox_id, data)
  end

  it "can get channel inbox" do
    stub_request(:get, "#{base_url}/channels/#{channel_id}/inbox").
      with( headers: headers).
      to_return(status: 200, body: channel_inbox_response)
    frontapp.get_channel_inbox(channel_id)
  end
end