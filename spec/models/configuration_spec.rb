require 'spec_helper'

describe Sisow::Configuration do

  before :each do
    @configuration = Sisow::Configuration.new
    @configuration.merchant_id  = '123'
    @configuration.merchant_key = 'abc'
    @configuration.shop_id      = '999'
    @configuration.debug_mode   = false
    @configuration.test_mode    = false
  end

  it "should tell wether test mode is enabled" do
    @configuration.test_mode = true
    @configuration.test_mode_enabled?.should == true
  end

  it "should tell wether debug mode is enabled" do
    @configuration.debug_mode = true
    @configuration.debug_mode_enabled?.should == true
  end

  it "should always save merchant_key as string" do
    @configuration.merchant_key = 123
    @configuration.merchant_key.should == '123'
  end

  it "should always save merchant_id as string" do
    @configuration.merchant_id = 123
    @configuration.merchant_id.should == '123'
  end


end
