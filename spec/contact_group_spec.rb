require 'spec_helper'
require 'frontapp'

RSpec.describe 'Contact Groups' do

  let(:headers) { json_headers }
  let(:frontapp) { Frontapp::Client.new(auth_token: auth_token) }
  let(:contact_group_id) { "grp_55c8c149" }
  let(:all_contact_groups_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/contact_groups"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/contacts/grp_55c8c149",
        "related": {
          "contacts": "https://api2.frontapp.com/contact_groups/grp_55c8c149/contacts"
        }
      },
      "id": "grp_55c8c149",
      "name": "Customers"
    }
  ]
}
    }
  }
  let(:create_contact_group_response) {
    %Q{
{
  "_links": {
    "self": "https://api2.frontapp.com/contacts/grp_55c8c149",
    "related": {
      "contacts": "https://api2.frontapp.com/contact_groups/grp_55c8c149/contacts"
    }
  },
  "id": "grp_55c8c149",
  "name": "Customers"
}
    }
  }
  let(:get_contact_group_contacts_response) {
    %Q{
{
  "_pagination": {},
  "_links": {
    "self": "https://api2.frontapp.com/contact_groups/grp_55c8c149/contacts"
  },
  "_results": [
    {
      "_links": {
        "self": "https://api2.frontapp.com/contacts/ctc_55c8c149",
        "related": {
          "notes": "https://api2.frontapp.com/contacts/ctc_55c8c149/notes",
          "conversations": "https://api2.frontapp.com/contacts/ctc_55c8c149/conversations"
        }
      },
      "id": "ctc_55c8c149",
      "name": "Calculon",
      "description": "#vip #robot #RIP",
      "avatar_url": "http://example.com/calculon.jpg",
      "is_spammer": true,
      "links": [
        "http://example.com"
      ],
      "handles": [
        {
          "handle": "@calculon",
          "source": "twitter"
        }
      ],
      "groups": [
        {
          "_links": {
            "self": "https://api2.frontapp.com/contacts/grp_55c8c149",
            "related": {
              "contacts": "https://api2.frontapp.com/contact_groups/grp_55c8c149/contacts"
            }
          },
          "id": "grp_55c8c149",
          "name": "Customers"
        }
      ]
    }
  ]
}
    }
  }

  it "can get all contact groups" do
    stub_request(:get, "#{base_url}/contact_groups").
      with( headers: headers).
      to_return(status: 200, body: all_contact_groups_response)
    frontapp.contact_groups
  end

  it "can create a contact group" do
    data = { name: "Customers" }
    stub_request(:post, "#{base_url}/contact_groups").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 201, body: create_contact_group_response)
    frontapp.create_contact_group!(data)
  end

  it "can delete a contact group" do
    stub_request(:delete, "#{base_url}/contact_groups/#{contact_group_id}").
      with( headers: headers).
      to_return(status: 204)
    frontapp.delete_contact_group!(contact_group_id)
  end

  it "can get all contacts in a contact group" do
    stub_request(:get, "#{base_url}/contact_groups/#{contact_group_id}/contacts").
      with( headers: headers).
      to_return(status: 200, body: get_contact_group_contacts_response)
    frontapp.get_contact_group_contacts(contact_group_id)
  end

  it "can add contacts to a contact group" do
    data = { contact_ids: ["ctc_55c8c149", "@calculon"] }
    stub_request(:post, "#{base_url}/contact_groups/#{contact_group_id}/contacts").
      with( body: data.to_json,
            headers: headers).
      to_return(status: 204)
    frontapp.add_contacts_to_contact_group!(contact_group_id, data)
  end
end