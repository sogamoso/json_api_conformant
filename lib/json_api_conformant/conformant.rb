require 'json-schema'

module JSON
  module API
    class Conformant
      SCHEMA_VERSION = 'draft'

      class << self
        def validate(data, schema=nil, options={})
          validator.validate(schema || schema_path, data, options)
        end

        def validate!(data, schema=nil, options={})
          validator.validate!(schema || schema_path, data, options)
        end

        def fully_validate(data, schema=nil, options={})
          validator.fully_validate(schema || schema_path, data, options)
        end

        private

        def validator
          JSON::Validator
        end

        def schema_path
          File.join(Pathname.new(File.dirname(__FILE__)).parent.parent,
                                 'schemas',
                                 "#{SCHEMA_VERSION}.json"
                   )
        end
      end
    end
  end
end
