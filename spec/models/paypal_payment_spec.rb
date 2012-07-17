require 'spec_helper'

describe Sisow::PaypalPayment do

  before :each do
    @payment = Sisow::PaypalPayment.new(
      :purchase_id   => 'Order 123',
      :issuer_id     => '99',
      :description   => 'Payment description',
      :entrance_code => 'entrancecode',
      :return_url    => 'http://example.com/return',
      :cancel_url    => 'http://example.com/cancel',
      :callback_url  => 'http://example.com/callback',
      :notify_url    => 'http://example.com/notify',
      :amount        => 1299,
      :locale        => 'EN'
    )
  end

  it "should have the 'paypal' payment method" do
    @payment.payment_method.should == 'paypalec'
  end

  it "should request a payment URL with the Sisow API" do
    VCR.use_cassette("paypal_payment") do
      @payment.payment_url.should =~ /https:\/\/www\.sisow\.nl\/Sisow\/iDeal\/Simulator\.aspx/
    end
  end

  it "should contain a transaction ID from Sisow" do
    VCR.use_cassette("paypal_payment") do
      @payment.transaction_id.should =~ /TEST\d{11}/
    end
  end

end
