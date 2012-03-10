module Sisow
  module Api
    class PingRequest < Request

      def method
        'PingRequest'
      end

      def params
        default_params
      end

      def clean(response)
        if response.pingresponse? && response.pingresponse.timestamp?
          response.pingresponse.timestamp
        end
      end

      def validate!
        true
      end

    end
  end
end
