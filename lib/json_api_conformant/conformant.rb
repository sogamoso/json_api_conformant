require 'json-schema'

module JSON
  module API
    class Conformant
      SCHEMA_VERSION = 'draft'

      class << self
        def valid?(data, options={})
          validator.validate(schema, data, options)
        end

        def validate(data, options={})
          validator.fully_validate(schema, data, options)
        end

        private

        def validator
          JSON::Validator
        end

        def schema
          File.join(Pathname.new(File.dirname(__FILE__)).parent.parent,
                                 'schemas',
                                 "#{SCHEMA_VERSION}.json"
                   )
        end
      end
    end
  end
end
