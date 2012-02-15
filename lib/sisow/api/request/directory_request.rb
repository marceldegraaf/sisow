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
        if response.directoryresponse? && response.directoryresponse.directory?
          response.directoryresponse.directory
        end
      end

      def validate!
        true
      end

    end
  end
end
