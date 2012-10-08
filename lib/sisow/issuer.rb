module Sisow
  class Issuer
    attr_accessor :id, :name

    def self.list
      @list ||= find_all_from_api
    end

    def self.find(issuer_id)
      list.select { |issuer| issuer.id.to_i == issuer_id.to_i }.first
    end

    def initialize(attributes = {})
      @id   = attributes[:id]
      @name = attributes[:name]
    end

    private

    def self.find_all_from_api
      hash = Sisow::Api::DirectoryRequest.perform

      hash.issuer = [ hash.issuer ] unless hash.issuer.is_a?(Array)

      hash.issuer.map do |issuer|
        new(
          :id => issuer.issuerid,
          :name => issuer.issuername
        )
      end
    end

  end
end
