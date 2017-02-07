require 'spec_helper'
require 'frontapp'

RSpec.describe 'Hash' do

  it "removes unpermitted keys from a Hash" do
    params = {
      name: "My thing",
      foo: "bar",
      settings: {
        url: "http//example.com",
        random_thing: "asdnkjrb"
      }
    }

    cleaned = params.permit(:name, settings: [:url])

    expect(cleaned).to eq( {
      name: "My thing",
      settings: {
        url: "http//example.com",
      }
    })
  end

end