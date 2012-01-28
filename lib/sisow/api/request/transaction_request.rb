module Sisow
  module Api
    class TransactionRequest < Request

      attr_accessor :purchase_id,
                    :issuer_id,
                    :description,
                    :amount,
                    :payment

      def initialize(payment)
        @payment = payment
      end

      def method
        'TransactionRequest'
      end

      def params
        default_params.merge!(transaction_params)
      end

      def clean(response)
        if response.transactionrequest? && response.transactionrequest.transaction?
          response.transactionrequest.transaction
        end
      end

      def sha1
        string = [
          payment.purchase_id,
          payment.entrance_code,
          payment.amount,
          payment.shop_id,
          Sisow.merchant_id,
          Sisow.merchant_key
        ].join

        Digest::SHA1.hexdigest(string)
      end

      private

        def transaction_params
          {
            :payment      => 'ideal',
            :purchaseid   => payment.purchase_id,
            :amount       => payment.amount,
            :issuerid     => payment.issuer_id,
            :description  => payment.description,
            :entrancecode => payment.entrance_code,
            :returnurl    => payment.return_url,
            :cancelurl    => payment.cancel_url,
            :callbackurl  => payment.callback_url,
            :notifyurl    => payment.notify_url,
            :sha1         => sha1
          }
        end

        def payment
          @payment
        end

    end
  end
end
