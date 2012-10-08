require 'spec_helper'

describe Sisow::Issuer do

  it "should list all available issuers" do
    VCR.use_cassette('issuer') do
      list = Sisow::Issuer.list
      list.size.should == 1
      list.first.name.should =~ /Sisow Bank/
      list.first.id.should_not be_nil
    end
  end

  it "should find an issuer by ID" do
    VCR.use_cassette('issuer') do
      issuer = Sisow::Issuer.find(99)
      issuer.class.should == Sisow::Issuer
      issuer.name.should =~ /Sisow Bank/
    end
  end

end
