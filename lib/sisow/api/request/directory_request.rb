module Sisow
  module Api
    class DirectoryRequest < Request

      def method
        'DirectoryRequest'
      end

      def params
        default_params
      end

      def clean(response)
        response['directoryresponse']['directory']
      end

    end
  end
end
