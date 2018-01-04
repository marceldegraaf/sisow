require 'spec_helper'

describe Sisow::Payment do

  before :each do
    @payment = Sisow::Payment.new(
      :purchase_id   => 'Order 123',
      :issuer_id     => '99',
      :description   => 'Payment description',
      :entrance_code => 'entrancecode',
      :return_url    => 'http://example.com/return',
      :cancel_url    => 'http://example.com/cancel',
      :callback_url  => 'http://example.com/callback',
      :notify_url    => 'http://example.com/notify',
      :amount        => 1299
    )
  end

  describe "validation" do

    it "should be valid" do
      @payment.valid?.should == true
    end

    it "entrance code should not contain - or _" do
      @payment.entrance_code = 'foo_bar'
      @payment.valid?.should == false
      @payment.entrance_code = 'foo-bar'
      @payment.valid?.should == false
    end

    it "purchase ID should not contain # or _" do
      @payment.purchase_id = 'Foo #123'
      @payment.valid?.should == false
      @payment.purchase_id = 'Foo_123'
      @payment.valid?.should == false
    end

    it "amount should not be nil or empty" do
      @payment.amount = nil
      @payment.valid?.should == false
      @payment.amount = ''
      @payment.valid?.should == false
    end

  end

  it "should raise an error when calling payment_method" do
    lambda{ @payment.payment_method }.should raise_error(RuntimeError, "Implement me in a subclass")
  end

  it "should raise an error if amount is missing" do
    @payment.amount = nil
    lambda{ @payment.payment_url }.should raise_error(Sisow::Exception, "One of your payment parameters is missing or invalid")
  end

  describe "with instance configuration" do
    it "should set merchant_id and merchant_key from attributes" do
      @payment.stub!(:payment_method).and_return('ideal')

      @payment.merchant_id = "1234"
      @payment.merchant_key = "4321"

      @payment.send(:request).merchant_id.should == "1234"
      @payment.send(:request).merchant_key.should == "4321"
    end
  end

end
