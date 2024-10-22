require 'uri'
require 'faraday'
require 'json'
require_relative 'client/attachments'
require_relative 'client/channels'
require_relative 'client/comments'
require_relative 'client/contact_groups'
require_relative 'client/contacts'
require_relative 'client/conversations'
require_relative 'client/events'
require_relative 'client/inboxes'
require_relative 'client/messages'
require_relative 'client/rules'
require_relative 'client/tags'
require_relative 'client/teammates'
require_relative 'client/teams'
require_relative 'client/topics'
require_relative 'client/links'
require_relative 'client/exports'
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

    def list(path, params = {}, &block)
      paginate = params.delete(:paginate)
      paginate = true if paginate.nil?

      items = block ? nil : []

      query = format_query(params)
      url = query.empty? ? path : "#{path}?#{query}"

      while url
        res = @connection.get(url)
        raise Error.from_response(res) unless res.success?
        response = JSON.parse(res.body)
        results = response["_results"] || []
        url = paginate ? response["_pagination"]&.dig("next") : nil

        unless results.empty?
          if items
            items.concat(results)
          else
            block.call(results)
          end
        end
      end

      items
    end

    def get(path)
      res = @connection.get(path)
      raise Error.from_response(res) unless res.success?
      JSON.parse(res.body)
    end

    def get_plain(path)
      res = @connection.get path do |req|
        req.headers[:accept] = 'text/plain'
      end

      raise Error.from_response(res) unless res.success?
      res.body.to_s
    end

    def get_raw(path)
      res = @connection.get(path)
      raise Error.from_response(res) unless res.success?
      res.body
    end

    def create(path, body)
      res = @connection.post path do |req|
        req.headers[:content_type] = 'application/json'
        req.body = body.to_json
      end

      raise Error.from_response(res) unless res.success?
      JSON.parse(res.body)
    end

    def create_without_response(path, body)
      res = @connection.post path do |req|
           req.headers[:content_type] = 'application/json'
           req.body = body.to_json
         end
      raise Error.from_response(res) unless res.success?
    end

    def update(path, body)
      res = @connection.patch path do |req|
        req.headers[:content_type] = 'application/json'
        req.body = body.to_json
      end
      raise Error.from_response(res) unless res.success?
    end

    def delete(path, body = {})
      res = @connection.delete path do |req|
        req.headers[:content_type] = 'application/json'
        req.body = body.to_json
      end
      raise Error.from_response(res) unless res.success?
    end

    private def format_query(params)
      res = []
      q = params.delete(:q)
      if q && q.is_a?(Hash)
        res << q.map do |k, v|
          case v
          when Symbol, String
            "q[#{k}]=#{URI.encode_www_form_component(v)}"
          when Array
            v.map { |c| "q[#{k}][]=#{URI.encode_www_form_component(c.to_s)}" }.join("&")
          else
            "q[#{k}]=#{URI.encode_www_form_component(v.to_s)}"
          end
        end
      end
      res << params.map {|k,v| "#{k}=#{URI.encode_www_form_component(v.to_s)}"}
      res.join("&")
    end

    private def base_url
      "https://api2.frontapp.com/"
    end

  end
end
