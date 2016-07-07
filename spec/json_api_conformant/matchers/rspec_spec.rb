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
      expected_message = [<<-ERROR.chomp]
Expected data to be JSON API conformant:
* The property '#/' of type Hash did not match any of the required schemas. The schema specific errors were:

- oneOf #0:
    - The property '#/included/0' did not contain a required property of 'id'
    -     The property '#/data' of type Array did not match any of the required schemas. The schema specific errors were:

    - oneOf #0:
        - The property '#/data' of type Array did not match the following type: object
    - oneOf #1:
        - The property '#/data/0' did not contain a required property of 'id'
    - oneOf #2:
        - The property '#/data' of type Array did not match the following type: null
- oneOf #1:
    - The property '#/' contains additional properties ["links", "data", "included"] outside of the schema when none are allowed
    - The property '#/' did not contain a required property of 'errors'
- oneOf #2:
    - The property '#/' contains additional properties ["data", "included"] outside of the schema when none are allowed
    - The property '#/' did not contain a required property of 'meta'
ERROR
      begin
        expect(json).to be_json_api_conformant
      rescue RSpec::Expectations::ExpectationNotMetError => e
       expect(e.to_s).to eq expected_message.join("\n* ")
      end
    end
  end
end
