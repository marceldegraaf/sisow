require 'spec_helper'

describe Sisow do

  it "should set the configuration" do
    Sisow.configure do |c|
      c.merchant_id  = "789"
      c.merchant_key = "foobar"
      c.debug_mode   = false
      c.test_mode    = true
      c.shop_id      = "myshop"
    end

    Sisow.configuration.merchant_id.should == "789"
    Sisow.configuration.merchant_key.should == "foobar"
    Sisow.configuration.debug_mode.should == false
    Sisow.configuration.test_mode.should == true
    Sisow.configuration.shop_id.should == "myshop"
  end

  it "should verify the Sisow API is reachable" do
    VCR.use_cassette('ping') do
      Sisow::Ping.should_receive(:send)
      Sisow.service_reachable?
    end
  end

end
