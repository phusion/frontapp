require 'spec_helper'
require 'frontapp'

RSpec.describe 'Rules' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:rule_id) { "rul_55c8c149" }
  let(:all_rules_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/rules"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/rules/rul_55c8c149"
      },
      "id": "rul_55c8c149",
      "name": "Important deliveries",
      "actions": [
        "Assign to Leela Turanga"
      ]
    }
  ]
}
    }
  }
  let(:get_rule_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/rules/rul_55c8c149"
  },
  "id": "rul_55c8c149",
  "name": "Important deliveries",
  "actions": [
    "Assign to Leela Turanga"
  ]
}
    }
  }

  it "can get all rules" do
    stub_request(:get, "#{base_url}/rules").
      with( headers: headers).
      to_return(status: 200, body: all_rules_response)
    frontapp.rules
  end

  it "can get a specific rule" do
    stub_request(:get, "#{base_url}/rules/#{rule_id}").
      with( headers: headers).
      to_return(status: 200, body: get_rule_response)
    frontapp.get_rule(rule_id)
  end

end