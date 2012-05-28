require 'spec_helper'

describe 'SendGridSmtpApi::VERSION' do
  it "returns string" do
    SendGridSmtpApi::VERSION.should be_an_instance_of(String)
  end
end
