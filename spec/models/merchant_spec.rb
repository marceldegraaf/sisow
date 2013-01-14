require 'spec_helper'

describe Sisow::Merchant do

  it "should retrieve payment methods" do
    VCR.use_cassette('merchant') do
      Sisow::Merchant.payment_methods.should == %w(ideal)
    end
  end

end
