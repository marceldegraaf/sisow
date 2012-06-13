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

  it "should not remove issuerid when it is an iDEAL payment" do
    payment = Sisow::IdealPayment.new
    request = Sisow::Api::TransactionRequest.new(payment)

    request.params.keys.should include(:issuerid)
  end

  it "should remove issuerid from params for Bancontact" do
    Sisow.configuration.stub!(:test_mode_enabled?).and_return(false)
    payment = Sisow::BancontactPayment.new
    request = Sisow::Api::TransactionRequest.new(payment)

    request.params.keys.should_not include(:issuerid)
  end

  it "should force issuerid to '99' for Bancontact in test mode" do
    payment = Sisow::BancontactPayment.new
    request = Sisow::Api::TransactionRequest.new(payment)

    request.params[:issuerid].should == '99'
  end

  it "should remove issuerid from params for Sofort" do
    Sisow.configuration.stub!(:test_mode_enabled?).and_return(false)
    payment = Sisow::SofortPayment.new
    request = Sisow::Api::TransactionRequest.new(payment)

    request.params.keys.should_not include(:issuerid)
  end

  it "should force issuerid to '99' for Sofort in test mode" do
    payment = Sisow::SofortPayment.new
    request = Sisow::Api::TransactionRequest.new(payment)

    request.params[:issuerid].should == '99'
  end

end
