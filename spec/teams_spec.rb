require 'spec_helper'
require 'frontapp'

RSpec.describe 'Teams' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:team_id) { "tea_55c8c149" }
  let(:all_teams_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/teams"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/teams/tim_55c8c149"
      },
      "id": "tim_55c8c149",
      "name": "Delivery"
    }
  ]
}
    }
  }
  let(:get_team_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/teams/tim_55c8c149"
  },
  "id": "tim_55c8c149",
  "name": "Delivery",
  "inboxes": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/inboxes/inb_55c8c149",
        "related": {
          "teammates": "https://api2.frontapp.com/inboxes/inb_55c8c149/teammates",
          "conversations": "https://api2.frontapp.com/inboxes/inb_55c8c149/conversations",
          "channels": "https://api2.frontapp.com/inboxes/inb_55c8c149/channels",
          "owner": "https://api2.frontapp.com/teams/tim_55c8c149"
        }
      },
      "id": "inb_55c8c149",
      "name": "Team",
      "is_private": false
    }
  ],
  "members": [
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

  it "can get all teams" do
    stub_request(:get, "#{base_url}/teams").
      with( headers: headers).
      to_return(status: 200, body: all_teams_response)
    frontapp.teams
  end

  it "can get a specific team" do
    stub_request(:get, "#{base_url}/teams/#{team_id}").
      with( headers: headers).
      to_return(status: 200, body: get_team_response)
    frontapp.get_team(team_id)
  end

end