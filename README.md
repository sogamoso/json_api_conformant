# JSON API Conformant
[![Build Status](https://travis-ci.org/sebasoga/json_api_conformant.svg?branch=master)](https://travis-ci.org/sebasoga/json_api_conformant)
[![Code Climate](https://codeclimate.com/github/sebasoga/json_api_conformant/badges/gpa.svg)](https://codeclimate.com/github/sebasoga/json_api_conformant)

When building an API in JSON it is important to follow conventions so that the
clients know how what to expect in the response when operating on the available
resources.

JSON API Conformant provides a narrow interface for validating JSON objects
against the [JSON API specification](http://jsonapi.org/) using
[the official schema](http://jsonapi.org/schema) and provides a custom RSpec
matcher for use in your tests.

**Important:** Currently v1.0 specification is used as the default base schema.
The base schema is not a perfect document. The fact that a JSON document
validates against this schema, it does not necessarily mean it is a valid JSON
API document. The schema is provided by JSON API for a base level sanity check.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_api_conformant'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_api_conformant

## Usage

Validate if your JSON object is JSON API conformant.
```ruby
valid_schema   = { "data" => [{ "type" => "posts", "id" => "1" }] }
invalid_schema = { "data" => [{ "posts" => "1" }] }

JSON::API::Conformant.valid?(valid_schema)        # => true
JSON::API::Conformant.valid?(invalid_schema)      # => false
```

Get errors when your JSON object is JSON API not conformant.
```ruby
valid_schema   = { "data" => [{ "type" => "posts", "id" => "1" }] }
invalid_schema = { "data" => [{ "posts" => "1" }] }

JSON::API::Conformant.validate(valid_schema)      # => []
JSON::API::Conformant.validate(invalid_schema)    # => ["The property '#/' of type object did not match any of the..."]
```

JSON API Conformant wraps [json-schema](https://github.com/hoxworth/json-schema),
so other options that validator accepts will work here too.
```ruby
schema = { "data" => [{ "posts" => "1" }] }

JSON::API::Conformant.valid?(schema, insert_defaults: true)
JSON::API::Conformant.validate(schema, errors_as_objects: true)
```


### RSpec Matcher
Only tested with RSpec 3.

It is pretty straighword to use.
```ruby
it "validates that's JSON API conformant" do
  data = {"posts" => [{"id" => "1"}]}
  expect(data).to be_json_api_conformant
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/json_api_conformant/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run the test suite (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## License

See [LICENSE](https://github.com/sebasoga/json_api_conformant/blob/master/LICENSE.txt)
for details.
