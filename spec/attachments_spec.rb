require 'spec_helper'
require 'frontapp'

RSpec.describe 'Attachments' do

  let(:headers) {
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{auth_token}",
    }
  }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:attachment_link_id) { "fil_55c8c149" }
  let(:download_attachment_response) {
    %Q{
      {
        "id":"fil_55c8c149",
        "filename":"some-file.pdf",
        "url":"https://www.example.com/xyz/some-file.pdf",
        "content_type":"application/pdf",
        "size": 325214,
        "metadata":{
          "is_inline":true,
          "cid":"c-xyz-123"
        }
      }
    }
  }

  it "can get a file attachment details" do
    stub_request(:get, "#{base_url}/download/#{attachment_link_id}").
      with( headers: headers).
      to_return(status: 200, body: File.read("spec/fixtures/sample.txt"))
    frontapp.download_attachment(attachment_link_id)
  end
end
