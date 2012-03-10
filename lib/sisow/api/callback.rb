module Sisow
  module Api
    class Callback

      attr_accessor :transaction_id,
                    :entrance_code,
                    :status,
                    :sha1

      def initialize(attributes = {})
        attributes.each do |k,v|
          send("#{k}=", v)
        end

        check_validity!
      end

      def success?
        @status == 'Success'
      end

      def expired?
        @status == 'Expired'
      end

      def cancelled?
        @status == 'Cancelled'
      end

      def failure?
        @status == 'Failure'
      end

      private

        def check_validity!
          string = [ @transaction_id, @entrance_code, @status, Sisow.configuration.merchant_id, Sisow.configuration.merchant_key ].join
          calculated_sha1 = Digest::SHA1.hexdigest(string)

          if calculated_sha1 != @sha1
            raise Sisow::Exception, "This callback is forged" and return
          end
        end

    end
  end
end
