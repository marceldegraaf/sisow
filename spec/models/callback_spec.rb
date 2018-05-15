require 'spec_helper'

describe Sisow::Api::Callback do

  before :each do
    @transaction_id = 'trx-123'
    @entrance_code  = 'entrancecode'
    @status = 'Success'
    @sha1 = Digest::SHA1.hexdigest(
      [
        @transaction_id,
        @entrance_code,
        @status,
        Sisow.configuration.merchant_id,
        Sisow.configuration.merchant_key
      ].join
    )

    @callback = Sisow::Api::Callback.new(
      :transaction_id => @transaction_id,
      :entrance_code  => @entrance_code,
      :status => @status,
      :sha1 => @sha1
    )
  end

  it "should be valid" do
    @callback.valid?.should == true
    lambda { @callback.validate! }.should_not raise_error
    @callback.validate!.should == true
  end

  it "should be valid with instance configuration" do
    Sisow.configure do |config|
      config.merchant_id  = "invalid"
      config.merchant_key = "invalid"
    end

    @callback = Sisow::Api::Callback.new(
      :merchant_id => ENV.fetch('MERCHANT_ID'),
      :merchant_key => ENV.fetch('MERCHANT_KEY'),
      :transaction_id => @transaction_id,
      :entrance_code  => @entrance_code,
      :status => @status,
      :sha1 => @sha1
    )

    @callback.valid?.should == true
    lambda { @callback.validate! }.should_not raise_error
    @callback.validate!.should == true
  end

  it "should raise an error when invalid" do
    @callback = Sisow::Api::Callback.new(
      :transaction_id => @transaction_id,
      :entrance_code  => @entrance_code,
      :status => @status,
      :sha1 => 'fake-hash'
    )

    @callback.valid?.should == false
    lambda { @callback.validate! }.should raise_error(Sisow::Exception, "This callback is forged")
  end

  describe "transaction status" do
    it "should be success" do
      @callback.success?.should == true
    end

    it "should be expired" do
      @callback.status = 'Expired'
      @callback.expired?.should == true
    end

    it "should be cancelled" do
      @callback.status = 'Cancelled'
      @callback.cancelled?.should == true
    end

    it "should be failure" do
      @callback.status = 'Failure'
      @callback.failure?.should == true
    end

    it "should be pending" do
      @callback.status = 'Pending'
      @callback.pending?.should == true
    end

    it "should be reversed" do
      @callback.status = 'Reversed'
      @callback.reversed?.should == true
    end
  end

end
