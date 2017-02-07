require_relative 'frontapp/utils/hash.rb'
require_relative 'frontapp/client.rb'
require 'openssl'
require 'http'
require 'json'

OpenSSL::SSL.send :remove_const, :VERIFY_PEER
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE