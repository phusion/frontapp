require 'spec_helper'
require 'frontapp'

RSpec.describe 'User agent' do
  let(:headers) { json_headers }
  let(:create_tag_data) {
    {name: "New tag name"}
  }
  let(:create_tag_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/tags/tag_55c8c149",
    "related": {
      "conversations": "https://api2.frontapp.com/tags/tag_55c8c149/conversations"
    }
  },
  "id": "tag_55c8c149",
  "name": "New tag name"
}
    }
  }

  it "has a default user agent" do
    stub_request(:post, "#{base_url}/tags").
      with(
        body: create_tag_data.to_json,
        headers: headers.merge("User-Agent": "Frontapp Ruby Gem #{Frontapp::VERSION}")).
      to_return(status: 201, body: create_tag_response)
    frontapp = Frontapp::Client.new(auth_token: auth_token)
    expect do
      frontapp.create_tag!(create_tag_data)
    end.to_not raise_error
  end

  it "can have a custom user agent" do
    user_agent = "Eye-Phone Integration (engineering@planet-express.com)"
    stub_request(:post, "#{base_url}/tags").
      with(
        body: create_tag_data.to_json,
        headers: headers.merge("User-Agent": user_agent)).
      to_return(status: 201, body: create_tag_response)
    frontapp = Frontapp::Client.new(auth_token: auth_token, user_agent: user_agent)
    expect do
      frontapp.create_tag!(create_tag_data)
    end
  end
end
