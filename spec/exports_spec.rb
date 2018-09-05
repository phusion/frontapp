require 'spec_helper'
require 'frontapp'

RSpec.describe 'Exports' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:export_id) { "exp_55c8c149" }
  let(:team_id) { "tim_55c8c149" }
  let(:all_exports_response) {
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/exports"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/exports/exp_55c8c149"
      },
      "id": "exp_55c8c149",
      "status": "running",
      "progress": 42,
      "url": "http://exports.frontapp.com/planet-express/export.csv",
      "filename": "export.csv",
      "size": 1000,
      "created_at": 1453770984.123,
      "query": {
        "inbox_id": "alt:address:team@planet-express.com",
        "start": 1428889003,
        "end": 1428889008,
        "timezone": "America/New_York",
        "should_export_events": false
      }
    }
  ]
}
    }
  }
  let(:get_export_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/exports/exp_55c8c149"
  },
  "id": "exp_55c8c149",
  "status": "running",
  "progress": 42,
  "url": "http://exports.frontapp.com/planet-express/export.csv",
  "filename": "export.csv",
  "size": 1000,
  "created_at": 1453770984.123,
  "query": {
    "inbox_id": "alt:address:team@planet-express.com",
    "start": 1428889003,
    "end": 1428889008,
    "timezone": "America/New_York",
    "should_export_events": false
  }
}
    }
  }
  let(:create_export_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/exports/exp_55c8c149"
  },
  "id": "exp_55c8c149",
  "status": "running",
  "progress": 42,
  "url": "http://exports.frontapp.com/planet-express/export.csv",
  "filename": "export.csv",
  "size": 1000,
  "created_at": 1453770984.123,
  "query": {
    "inbox_id": "alt:address:team@planet-express.com",
    "start": 1428889003,
    "end": 1428889008,
    "timezone": "America/New_York",
    "should_export_events": false
  }
}
    }
  }

  it "can get all exports" do
    stub_request(:get, "#{base_url}/exports").
      with( headers: headers).
      to_return(status: 200, body: all_exports_response)
    frontapp.exports
  end

  it "can get a specific export" do
    stub_request(:get, "#{base_url}/exports/#{export_id}").
      with( headers: headers).
      to_return(status: 200, body: get_export_response)
    frontapp.get_export(export_id)
  end

  it "can create a export" do
    data = {
      inbox_id: "alt:address:team@planet-express.com",
      start: 1428889003,
      end: 1428889008,
      timezone: "America/New_York",
      should_export_events: false
    }
    stub_request(:post, "#{base_url}/exports").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: create_export_response)
    frontapp.create_export!(data)
  end

  it "can create a export for a team" do
    data = {
      inbox_id: "alt:address:team@planet-express.com",
      start: 1428889003,
      end: 1428889008,
      timezone: "America/New_York",
      should_export_events: false
    }
    stub_request(:post, "#{base_url}/teams/#{team_id}/exports").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: create_export_response)
    frontapp.create_export_for_team!(team_id, data)
  end
end