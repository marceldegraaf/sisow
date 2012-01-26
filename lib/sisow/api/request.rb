module Sisow
  module Api
    class Request

      include HTTParty
      base_uri "http://www.sisow.nl/Sisow/iDeal/RestHandler.ashx/"
      #debug_output $stderr

      attr_accessor :uri

      def self.perform
        new.perform
      end

      def perform
        return unless can_perform?

        response = self.class.get(uri)
        clean(response)
      end

      def default_params
        {
          :merchant_id  => Sisow.merchant_id,
          :merchant_key => Sisow.merchant_key,
          :test         => Sisow.test_mode_enabled?? test_mode_param : nil
        }
      end

      def params; raise 'Implement me in a subclass'; end
      def method; raise 'Implement me in a subclass'; end
      def clean;  raise 'Implement me in a subclass'; end

      private

        def can_perform?
          Sisow.merchant_id.present? && Sisow.merchant_key.present?
        end

        def uri
          [ '/', method, '?', encoded_params ].join
        end

        def encoded_params
          params.map { |k,v| [ k, '=', v ].join }.join('&')
        end

        def test_mode_param
          'true'
        end

    end
  end
end
