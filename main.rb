require_relative 'medical_center_faker'
require 'yaml'

def symbolize(obj)
  if obj.is_a? Hash
    return obj.inject({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = symbolize(v) }
    end
  elsif obj.is_a? Array
    return obj.map { |memo| symbolize(memo) }
  end
  obj
end

config = symbolize(YAML.load_file('config.yml'))

faker = MedicalCenterFaker.new(config[:target_uri], config[:async_requests])

faker.run(config[:requests_meta])
