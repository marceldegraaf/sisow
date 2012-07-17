require 'rubygems'
require 'httparty'
require 'hashie'
require 'cgi'

require 'sisow/configuration'
require 'sisow/error_response'
require 'sisow/exception'
require 'sisow/issuer'
require 'sisow/ping'
require 'sisow/payment'
require 'sisow/payment/ideal_payment'
require 'sisow/payment/bancontact_payment'
require 'sisow/payment/sofort_payment'
require 'sisow/payment/paypal_payment'
require 'sisow/merchant'
require 'sisow/api/request'
require 'sisow/api/request/directory_request'
require 'sisow/api/request/ping_request'
require 'sisow/api/request/transaction_request'
require 'sisow/api/request/check_merchant_request'
require 'sisow/api/callback'

module Sisow

  class << self

    def service_reachable?
      ping = Sisow::Ping.send
    end

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

  end

end
