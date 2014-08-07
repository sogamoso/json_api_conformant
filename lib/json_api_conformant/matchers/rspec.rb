require 'rspec/expectations'
require 'json_api_conformant/conformant'

RSpec::Matchers.define :be_json_api_conformant do
  match do |data|
    json_api_conformant? data
  end

  failure_message do |data|
    errors = get_errors_in data
    message_for errors
  end

  failure_message_when_negated do |data|
    "Expected data not to be JSON API conformant"
  end

  private

  def json_api_conformant?(data)
    JSON::API::Conformant.validate(data)
  end

  def get_errors_in(data)
    JSON::API::Conformant.fully_validate(data)
  end

  def message_for(errors)
    error_message = ['Expected data to be JSON API conformant:'] + errors
    error_message.join("\n* ")
  end
end
