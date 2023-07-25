require 'uri'
require 'faraday'
require 'json'
require_relative 'client/attachments.rb'
require_relative 'client/channels.rb'
require_relative 'client/comments.rb'
require_relative 'client/contact_groups.rb'
require_relative 'client/contacts.rb'
require_relative 'client/conversations.rb'
require_relative 'client/events.rb'
require_relative 'client/inboxes.rb'
require_relative 'client/messages.rb'
require_relative 'client/rules.rb'
require_relative 'client/tags.rb'
require_relative 'client/teammates.rb'
require_relative 'client/teams.rb'
require_relative 'client/topics.rb'
require_relative 'client/links.rb'
require_relative 'client/exports.rb'
require_relative 'error'
require_relative 'version'

module Frontapp
  class Client

    include Frontapp::Client::Attachments
    include Frontapp::Client::Channels
    include Frontapp::Client::Comments
    include Frontapp::Client::ContactGroups
    include Frontapp::Client::Contacts
    include Frontapp::Client::Conversations
    include Frontapp::Client::Events
    include Frontapp::Client::Inboxes
    include Frontapp::Client::Messages
    include Frontapp::Client::Rules
    include Frontapp::Client::Tags
    include Frontapp::Client::Teammates
    include Frontapp::Client::Teams
    include Frontapp::Client::Topics
    include Frontapp::Client::Links
    include Frontapp::Client::Exports

    def initialize(options={})
      auth_token = options[:auth_token]
      user_agent = options[:user_agent] || "Frontapp Ruby Gem #{VERSION}"
      @connection = Faraday.new(
        url: base_url,
        headers: {
          Accept: "application/json",
          Authorization: "Bearer #{auth_token}",
          "User-Agent": user_agent
        })
    end

    def list(path, params = {})
      items = []
      last_page = false
      query = format_query(params)
      url = "#{path}?#{query}"
      until last_page
        res = @connection.get(url)
        raise Error.from_response(res) unless res.success?
        response = JSON.parse(res.body)
        items.concat(response["_results"]) if response["_results"]
        pagination = response["_pagination"]
        if pagination.nil? || pagination["next"].nil?
          last_page = true
        else
          url = pagination["next"]
        end
      end
      items
    end

    def get(path)
      res = @connection.get("#{path}")
      raise Error.from_response(res) unless res.success?
      JSON.parse(res.body)
    end

    def get_plain(path)
      res = @connection.get("#{path}", headers: {Accept: "text/plain"})
      raise Error.from_response(res) unless res.success?
      res.body.to_s
    end

    def get_raw(path)
      res = @connection.get("#{path}")
      raise Error.from_response(res) unless res.success?
      res.body
    end

    def create(path, body)
      res = @connection.post("#{path}", body: body)
      response = JSON.parse(res.body)
      raise Error.from_response(res) unless res.success?
      response
    end

    def create_without_response(path, body)
      res = @connection.post("#{path}", body: body)
      raise Error.from_response(res) unless res.success?
    end

    def update(path, body)
      res = @connection.patch("#{path}", body: body)
      raise Error.from_response(res) unless res.success?
    end

    def delete(path, body = {})
      res = @connection.delete("#{path}", body: body)
      raise Error.from_response(res) unless res.success?
    end

  private
    def format_query(params)
      res = []
      q = params.delete(:q)
      if q && q.is_a?(Hash)
        res << q.map do |k, v|
          case v
          when Symbol, String
            "q[#{k}]=#{URI.encode_www_form_component(v)}"
          when Array then
            v.map { |c| "q[#{k}][]=#{URI.encode_www_form_component(c.to_s)}" }.join("&")
          else
            "q[#{k}]=#{URI.encode_www_form_component(v.to_s)}"
          end
        end
      end
      res << params.map {|k,v| "#{k}=#{URI.encode_www_form_component(v.to_s)}"}
      res.join("&")
    end

    def base_url
      "https://api2.frontapp.com/"
    end

  end
end