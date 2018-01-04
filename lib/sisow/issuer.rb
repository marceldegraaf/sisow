module Sisow
  class Issuer
    attr_accessor :id, :name

    def self.list(merchant_id: nil, merchant_key: nil)
      @list ||= find_all_from_api(merchant_id, merchant_key)
    end

    def self.find(issuer_id)
      list.select { |issuer| issuer.id.to_i == issuer_id.to_i }.first
    end

    def initialize(attributes = {})
      @id   = attributes[:id]
      @name = attributes[:name]
    end

    private

    def self.find_all_from_api(merchant_id = nil, merchant_key = nil)
      hash = Sisow::Api::DirectoryRequest.perform(merchant_id: merchant_id, merchant_key: merchant_key)

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
