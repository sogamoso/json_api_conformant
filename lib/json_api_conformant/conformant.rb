require 'json-schema'

module JSON
  module API
    class Conformant
      DEFAULT_SCHEMA_VERSION = 'draft'

      class << self
        def valid?(data, version: DEFAULT_SCHEMA_VERSION, **options)
          validator.validate(schema(version), data, options)
        end

        def validate(data, version: DEFAULT_SCHEMA_VERSION, **options)
          validator.fully_validate(schema(version), data, options)
        end

        private

        def validator
          JSON::Validator
        end

        def schema(version)
          File.join(Pathname.new(File.dirname(__FILE__)).parent.parent,
                                 'schemas',
                                 "#{version}.json"
                   )
        end
      end
    end
  end
end
