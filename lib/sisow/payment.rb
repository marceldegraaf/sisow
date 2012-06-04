module Sisow
  class Payment

    attr_accessor :purchase_id,
                  :issuer_id,
                  :description,
                  :amount,
                  :entrance_code,
                  :return_url,
                  :cancel_url,
                  :callback_url,
                  :notify_url

    def initialize(attributes = {})
      attributes.each do |k,v|
        send("#{k}=", v)
      end
    end

    def payment_url
      CGI::unescape(response.issuerurl) if response.issuerurl?
    end

    def transaction_id
      response.trxid if response.trxid?
    end

    def shop_id
      Sisow.configuration.shop_id
    end

    def valid?
      entrance_code.index(/-|_/).nil? &&
      purchase_id.index(/\#|_/).nil? &&
      (!amount.nil? && amount != '')
    end

    def payment_method; raise 'Implement me in a subclass'; end

    private

      def response
        @raw_response ||= request.perform
      end

      def request
        @request ||= Sisow::Api::TransactionRequest.new(self)
      end

  end
end
