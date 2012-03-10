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

end
