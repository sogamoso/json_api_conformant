require 'json'

module RSpecHelper
  def parse_fixture(filename)
    filepath = File.join(Pathname.new(File.dirname(__FILE__)).parent, 'fixtures', "#{filename}.json")
    file = File.read(filepath)
    JSON.parse(file)
  end
end
