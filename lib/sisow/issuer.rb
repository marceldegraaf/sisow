module Sisow
  class Issuer
    attr_accessor :id, :name

    def self.list
      hash = Sisow::Api::DirectoryRequest.perform

      hash.issuer = [ hash.issuer ] unless hash.issuer.is_a?(Array)

      hash.issuer.map do |issuer|
        new(
          :id => issuer.issuerid,
          :name => issuer.issuername
        )
      end
    end

    def initialize(attributes = {})
      @id   = attributes[:id]
      @name = attributes[:name]
    end

  end
end
