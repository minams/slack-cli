require_relative "test_helper.rb"
require "pry"

describe "Channel class" do
  it "Creates an instance of the Channel class" do
    new_channel = Slack::Channel.new("id", "name")
    expect(new_channel).must_be_instance_of Slack::Channel
  end
end

describe "Get method" do
  it "Successfully GETs response from Slack API" do
    VCR.use_cassette("channel_find") do
      response = Slack::Channel.get

      expect(response["ok"]).must_equal true
    end
  end
end

describe "list_all method" do
  it "gives a list of all user information from the API and returns a value of a 'general' channel name" do
    VCR.use_cassette("channel_find") do
      list_response = Slack::Channel.list_all

      expect(list_response.length).must_equal 3
      expect(list_response).must_include "general"
      expect(list_response).wont_include "test_channel"
    end
  end
end
