require 'uri'
require 'http'
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

    def initialize(options={})
      auth_token = options[:auth_token]
      @headers = HTTP.timeout(:per_operation, write: 2, connect: 5, read: 10).headers({
        Accept: "application/json",
        Authorization: "Bearer #{auth_token}"
      })
    end

    def list(path, params = {})
      items = []
      last_page = false
      query = format_query(params)
      url = "#{base_url}#{path}?#{query}"
      until last_page
        res = @headers.get(url)
        decode_status(res)
        response = JSON.parse(res.to_s)
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
      res = @headers.get("#{base_url}#{path}")
      decode_status(res)
      JSON.parse(res.to_s)
    end

    def create(path, body)
      res = @headers.post("#{base_url}#{path}", json: body)
      decode_status(res)
      response = JSON.parse(res.to_s)
      if !res.status.success?
        raise "Response: #{res.inspect}\n Body: #{res.body}\nRequest: #{body.to_json.inspect}"
      end
      response
    end

    def create_without_response(path, body)
      res = @headers.post("#{base_url}#{path}", json: body)
      decode_status(res)
      if !res.status.success?
        raise "Response: #{res.inspect}\n Body: #{res.body}\nRequest: #{body.to_json.inspect}"
      end
    end

    def update(path, body)
      res = @headers.patch("#{base_url}#{path}", json: body)
      decode_status(res)
      if !res.status.success?
        raise "Response: #{res.inspect}\n Body: #{res.body}\nRequest: #{body.to_json.inspect}"
      end
    end

    def delete(path, body = {})
      res = @headers.delete("#{base_url}#{path}", json: body)
      decode_status(res)
      if !res.status.success?
        raise "Response: #{res.inspect}\n Body: #{res.body}\nRequest: #{body.to_json.inspect}"
      end
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

    def base_url
      "https://api2.frontapp.com/"
    end

    def decode_status(response)
      if response.status == 429
        context = {}
        %w[Retry-After X-RateLimit-Limit X-RateLimit-Remaining X-RateLimit-Reset].each do |header|
          context[header] = response.headers[header]
        end

        raise RateLimitError.new(429, context)
      end
    end
  end
end
