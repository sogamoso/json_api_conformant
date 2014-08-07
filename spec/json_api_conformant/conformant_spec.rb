require 'spec_helper'

describe JSON::API::Conformant do

  let(:valid_data)   { parse_fixture('valid') }
  let(:invalid_data) { parse_fixture('invalid') }

  subject { JSON::API::Conformant }

  describe ".validate" do
    context "when data is valid" do
      it "is true" do
        expect(subject.validate valid_data).to be true
      end
    end

    context "when data is invalid" do
      it "is false" do
        expect(subject.validate invalid_data).to be false
      end
    end
  end

  describe ".validate!" do
    context "when data is valid" do
      it "is true" do
        expect(subject.validate! valid_data).to be true
      end
    end

    context "when data is invalid" do
      it "raises a JSON::Schema::ValidationError" do
        expect do
          subject.validate! invalid_data
        end.to raise_error JSON::Schema::ValidationError
      end
    end
  end

  describe ".fully_validate" do
    context "when data is valid" do
      it "returns an empty array" do
        expect(subject.fully_validate valid_data).to eq []
      end
    end

    context "when data is invalid" do
      it "returns an array with the errors" do
        errors = [
          "The property '#/posts/0' did not contain a required property of 'id' in schema http://jsonapi.org/schema#",
          "The property '#/linked/people/0' did not contain a required property of 'id' in schema http://jsonapi.org/schema#"]
        expect(subject.fully_validate invalid_data).to eq errors
      end
    end
  end
end
