require 'rspec/json_matcher'

RSpec.configure do |config|
  config.include RSpec::JsonMatcher, type: :request
end
