require 'spec_helper'

describe Sisow::Api::TransactionRequest do

  it "should raise an error if API response has been forged" do
    response = Hashie::Mash.new
    response.transactionrequest = {
      :signature => {
        :sha1 => 'this_is_not_a_correct_sha1_hash'
      },
      :transaction => {
        :trxid => '123',
        :issuerurl => 'http://example.com'
      }
    }

    payment = Sisow::IdealPayment.new
    request = Sisow::Api::TransactionRequest.new(payment)

    lambda{ request.clean(response) }.should raise_error(Sisow::Exception, "This response has been forged")

  end

end
