require 'crack'

module Sisow
  module Api
    class Request

      BASE_URI = "https://www.sisow.nl/Sisow/iDeal/RestHandler.ashx"

      attr_writer :merchant_id,
                  :merchant_key

      def merchant_id
        @merchant_id || Sisow.configuration.merchant_id
      end

      def merchant_key
        @merchant_key || Sisow.configuration.merchant_key
      end

      def self.perform(merchant_id: nil, merchant_key: nil)
        new.tap do |r|
          r.merchant_id = merchant_id if merchant_id
          r.merchant_key = merchant_key if merchant_key
        end.perform
      end

      def perform
        raise Sisow::Exception, 'Your merchant_id or merchant_key are not set' unless can_perform?

        validate!

        http_response = HTTPI.get(base_uri + uri)
        parsed_response = Crack::XML.parse(http_response.body)
        response = Hashie::Mash.new(parsed_response)

        error!(response) if response.errorresponse?

        clean(response)
      end

      def default_params
        {
          :merchantid  => merchant_id,
          :test        => Sisow.configuration.test_mode_enabled?? test_mode_param : nil
        }
      end

      def params;     raise 'Implement me in a subclass'; end
      def method;     raise 'Implement me in a subclass'; end
      def clean;      raise 'Implement me in a subclass'; end
      def validate!;  raise 'Implement me in a subclass'; end

      private

        def can_perform?
          !(merchant_id.nil? || merchant_id.empty?) && !(merchant_key.nil? || merchant_key.empty?)
        end

        def uri
          [ '/', method, '?', encoded_params ].join
        end

        def params_string
          params.map { |k,v| [ k, '=', v ].join }.join('&')
        end

        def encoded_params
          URI.encode(params_string)
        end

        def test_mode_param
          'true'
        end

        def error!(response)
          error_response = Sisow::ErrorResponse.new(response)
          raise Sisow::Exception, error_response.message and return
        end

        def base_uri
          Sisow.configuration.base_uri || BASE_URI
        end

    end
  end
end
