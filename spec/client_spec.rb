require 'spec_helper'
require 'frontapp'

RSpec.describe 'Client' do
  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }

  let(:result_1) { { "id" => "1" } }
  let(:result_2) { { "id" => "2" } }
  let(:pagination) { { "next" => "#{base_url}/conversations?page=2" } }
  let(:response_1) { { "_results" => [result_1], "_pagination" => pagination } }
  let(:response_2) { { "_results" => [result_2], "_pagination" => {} } }

  it "can list without a block" do
    stub_request(:get, "#{base_url}/conversations").
      with(headers: headers).
      to_return(status: 200, body: JSON.generate(response_1))
    stub_request(:get, "#{base_url}/conversations?page=2").
      with(headers: headers).
      to_return(status: 200, body: JSON.generate(response_2))
    results = frontapp.conversations
    expect(results).to eq([result_1, result_2])
  end

  it "can list with a block" do
    stub_request(:get, "#{base_url}/conversations").
      with(headers: headers).
      to_return(status: 200, body: JSON.generate(response_1))
    stub_request(:get, "#{base_url}/conversations?page=2").
      with(headers: headers).
      to_return(status: 200, body: JSON.generate(response_2))
    results = []
    frontapp.conversations do |conversations|
      results.concat(converations)
    end
    expect(results).to eq([result_1, result_2])
  end

  it "can list with params" do
    stub_request(:get, "#{base_url}/conversations?page=2").
      with(headers: headers).
      to_return(status: 200, body: JSON.generate(response_2))
    results = frontapp.conversations(page: 2)
    expect(results).to eq([result_2])
  end
end
