require 'spec_helper'

describe SendGridSmtpApi::ApiHeader do
  let(:header) { SendGridSmtpApi::ApiHeader.new }
  describe "#to_json" do
    it "returns valid json if no data was set" do
      header.to_json.should eql "{}"
    end

    it "contains 1 recipient (as array)" do
      header.add_recipients 'email@email.com'
      header.to_json.should eql '{ "to":[  "email@email.com"]}'
    end

    it "contaions an array of recipients" do
      header.add_recipients %w(email1@email.com email2@email.com)
      header.to_json.should eql '{ "to":[  "email1@email.com",  "email2@email.com"]}'
    end

    it "contains substitution" do
      header.substitute :var1, 'Hello'
      header.to_json.should eql '{ "sub":{  "var1":[   "Hello"]}}'
    end

    it "contains uniq args" do
      header.uniq_args :arg1 => 'val1'
      header.to_json.should eql '{ "unique_args":{  "arg1":"val1"}}'
    end

    it "contains category" do
      header.category 'category_name'
      header.to_json.should eql '{ "category":"category_name"}'
    end

    it "contains filter settings" do
      header.add_filter_setting :filter1, :setting1, 'val1'
      header.to_json.should eql '{ "filters":{  "filter1":{   "settings":{    "setting1":"val1"}}}}'
    end
  end
end
