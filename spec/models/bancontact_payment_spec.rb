require 'spec_helper'

describe Sisow::BancontactPayment do

  before :each do
    @payment = Sisow::BancontactPayment.new(
      :purchase_id   => 'purchase-123',
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

  it "should have the 'mistercash' payment method" do
    @payment.payment_method.should == 'mistercash'
  end

  it "should request a payment URL with the Sisow API" do
    VCR.use_cassette("bancontact_payment") do
      @payment.payment_url.should =~ /https:\/\/www\.sisow\.nl\/Sisow\/iDeal\/Simulator\.aspx/
    end
  end

end
