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
        if response.pingresponse? && response.timestamp?
          response.pingresponse.timestamp
        end
      end

    end
  end
end
