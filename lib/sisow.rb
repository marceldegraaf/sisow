require 'httparty'

require 'sisow/issuer'
require 'sisow/payment'
require 'sisow/api/request'
require 'sisow/api/request/directory_request'

module Sisow

  mattr_accessor :merchant_id, :merchant_key, :test_mode

  @@_ran_once = false

  def self.setup
    yield self if @@_ran_once == false
    @@_ran_once = true
  end

  def self.test_mode_enabled?
    @@test_mode ||= false
  end

end
