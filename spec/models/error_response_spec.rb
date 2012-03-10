require 'spec_helper'

describe Sisow::ErrorResponse do

  before :all do
    response = Hashie::Mash.new
    response.errorresponse = {:error => {:errorcode => "TA123", :errormessage => "Foo bar"}}
    @error_response = Sisow::ErrorResponse.new(response)
  end

  it "should display a message, given a response" do
    @error_response.message.should == "An error occurred: TA123. Foo bar"
  end

end
