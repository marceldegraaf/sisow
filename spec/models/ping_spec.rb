require 'spec_helper'

describe Sisow::Ping do

  it "should send a ping message" do
    VCR.use_cassette('ping') do
      Sisow::Ping.send.class.should == String
    end
  end

end
