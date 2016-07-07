require 'spec_helper'

describe JSON::API::Conformant do

  let(:valid_data)   { parse_fixture('valid') }
  let(:invalid_data) { parse_fixture('invalid') }

  subject { JSON::API::Conformant }

  describe ".validate" do
    context "when data is valid" do
      it "is true" do
        expect(subject.valid? valid_data).to be true
      end
    end

    context "when data is invalid" do
      it "is false" do
        expect(subject.valid? invalid_data).to be false
      end
    end

    describe "version" do
      it "defaults to draft" do
        expect(subject).to receive(:schema).with("draft").and_call_original
        subject.validate({})
      end

      it "can be overridden" do
        expect(subject).to receive(:schema).with("1.0").and_call_original
        subject.validate({}, version: "1.0")
      end
    end
  end

  describe ".validate" do
    context "when data is valid" do
      it "returns an empty array" do
        expect(subject.validate valid_data).to eq []
      end
    end

    context "when data is invalid" do
      it "returns an array with the errors" do
        errors = [
          "The property '#/posts/0' did not contain a required property of 'id' in schema http://jsonapi.org/schema#",
          "The property '#/linked/people/0' did not contain a required property of 'id' in schema http://jsonapi.org/schema#"]
        expect(subject.validate invalid_data).to eq errors
      end
    end

    describe "version" do
      it "defaults to draft" do
        expect(subject).to receive(:schema).with("draft").and_call_original
        subject.validate({})
      end

      it "can be overridden" do
        expect(subject).to receive(:schema).with("1.0").and_call_original
        subject.validate({}, version: "1.0")
      end
    end
  end

  describe "#schema" do
    it "allows version to be specified" do
      expect(subject.send(:schema, "1.0")).to end_with "1.0.json"
      expect(subject.send(:schema, "draft")).to end_with "draft.json"
    end
  end
end
