require 'httparty'
require 'hashie'

require 'sisow/error_response'
require 'sisow/exception'
require 'sisow/issuer'
require 'sisow/ping'
require 'sisow/payment'
require 'sisow/payment/ideal_payment'
require 'sisow/payment/bancontact_payment'
require 'sisow/api/request'
require 'sisow/api/request/directory_request'
require 'sisow/api/request/ping_request'
require 'sisow/api/request/transaction_request'
require 'sisow/api/callback'

module Sisow

  mattr_accessor :merchant_id, :merchant_key, :test_mode, :debug, :shop_id

  @@_ran_once = false

  def self.setup
    yield self if @@_ran_once == false
    @@_ran_once = true
  end

  def self.test_mode_enabled?
    @@test_mode ||= false
  end

  def self.debug_mode_enabled?
    @@debug ||= false
  end

  def self.service_reachable?
    ping = Sisow::Ping.send
    ping.present?
  end

  def self.shop_id
    @@shop_id || ''
  end

end
