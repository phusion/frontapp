require 'uri'
require 'httparty'
require 'json'
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
require_relative 'error.rb'

module Frontapp
  class Client
    include HTTParty

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

    base_uri('https://api2.frontapp.com')

    def initialize(options={})
      auth_token = options[:auth_token]
      self.class.debug_output($stdout) if options[:debug]

      self.class.headers(
        'Accept' => "application/json",
        'Authorization' => "Bearer #{auth_token}"
      )
    end

    def list(path, params = {})
      items = []
      last_page = false
      query = format_query(params)
      url = "#{path}?#{query}"
      until last_page
        res = self.class.get(url)
        decode_status(res)
        response = JSON.parse(res.parsed_response) ## ??
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
      res = self.class.get(path)
      decode_status(res)
      JSON.parse(res.parsed_response) ## ??
    end

    def create(path, body)
      res = self.class.post(path, body: body.to_json)
      decode_status(res)
      response = JSON.parse(res.parsed_response) ## ??
      response
    end

    def create_without_response(path, body)
      res = self.class.post(path, body: body.to_json)
      decode_status(res)
    end

    def update(path, body)
      res = self.class.patch(path, body: body.to_json)
      decode_status(res)
    end

    def delete(path, body = {})
      res = self.class.delete(path, body: body.to_json)
      decode_status(res)
    end

  private
    def format_query(params)
      res = []
      q = params.delete(:q)
      if q && q.is_a?(Hash)
        res << q.map do |k, v|
          case v
          when Symbol, String
            "q[#{k}][]=#{URI.encode(v)}"
          when Array then
            v.map { |c| "q[#{k}][]=#{URI.encode(c)}" }.join("&")
          end
        end
      end
      res << params.map {|k,v| "#{k}=#{URI.encode(v)}"}
      res.join("&")
    end

    def decode_status(response)
      if response.code == 429
        context = {}
        %w[Retry-After X-RateLimit-Limit X-RateLimit-Remaining X-RateLimit-Reset].each do |header|
          context[header] = response.headers[header]
        end

        raise RateLimitError.new(429, context)
      elsif !response.success?
        raise Error.new(response.code, response.parsed_response)
      end
    end
  end
end
