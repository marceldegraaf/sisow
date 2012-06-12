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
      end

      def valid?
        valid_callback == true
      end

      def validate!
        return true if valid_callback == true
        raise Sisow::Exception, "This callback is forged" and return if valid_callback == false
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

        def valid_callback
          string = [ @transaction_id, @entrance_code, @status, Sisow.configuration.merchant_id, Sisow.configuration.merchant_key ].join
          calculated_sha1 = Digest::SHA1.hexdigest(string)

          calculated_sha1 == @sha1
        end

    end
  end
end
