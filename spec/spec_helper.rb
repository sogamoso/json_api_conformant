ENV["env"] ||= "test"

require 'json_api_conformant'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.include RSpecHelper
end
