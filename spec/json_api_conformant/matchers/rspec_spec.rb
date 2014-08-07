require 'spec_helper'

RSpec.describe "be_json_api_conformant matcher" do

  context "when the JSON object is valid" do
    it "is JSON API conformant" do
      json = parse_fixture('valid')
      expect(json).to be_json_api_conformant
    end

    it "returns the correct message when the test fails" do
      json = parse_fixture('valid')
      expected_message = 'Expected data not to be JSON API conformant'
      begin
        expect(json).not_to be_json_api_conformant
      rescue RSpec::Expectations::ExpectationNotMetError => e
       expect(e.to_s).to eq expected_message
      end
    end
  end

  context "when then JSON object is invalid" do
    it "is not JSON API conformant" do
      json = parse_fixture('invalid')
      expect(json).not_to be_json_api_conformant
    end

    it "returns the correct message when the test fails" do
      json = parse_fixture('invalid')
      expected_message = ["Expected data to be JSON API conformant:",
                          "The property '#/posts/0' did not contain a required property of 'id' in schema http://jsonapi.org/schema#",
                          "The property '#/linked/people/0' did not contain a required property of 'id' in schema http://jsonapi.org/schema#"]
      begin
        expect(json).to be_json_api_conformant
      rescue RSpec::Expectations::ExpectationNotMetError => e
       expect(e.to_s).to eq expected_message.join("\n* ")
      end
    end
  end
end
