module Sisow
  class CheckMerchantRequest < Sisow::Api::Request

    def method
      'CheckMerchantRequest'
    end

    def params
      default_params.merge!(merchant_params)
    end

    def clean(response)
      if response.checkmerchantresponse? && response.checkmerchantresponse.merchant?
        response.checkmerchantresponse.merchant.payments
      end
    end

    def validate!
      true
    end

    private

      def merchant_params
        {
          :sha1 => sha1
        }
      end

      def sha1
        string = [
          Sisow.configuration.merchant_id,
          Sisow.configuration.merchant_key
        ].join

        Digest::SHA1.hexdigest(string)
      end

  end
end
