module Sisow
  class Issuer
    attr_accessor :id, :name

    def self.list
      hash = Sisow::Api::DirectoryRequest.perform

      hash.map do |k, v|
        new(:id => v['issuerid'], :name => v['issuername'])
      end
    end

    def initialize(attributes = {})
      @id   = attributes[:id]
      @name = attributes[:name]
    end

  end
end
