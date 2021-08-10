require_relative "lib/garage/lazy/version"

Gem::Specification.new do |spec|
  spec.name = "garage-lazy"
  spec.version = Garage::Lazy::VERSION
  spec.authors = ["Shota Iguchi"]
  spec.email = ["shota-iguchi@cookpad.com"]
  spec.summary = "Garage extension to render json by lazy evaluation"
  spec.license = "MIT"
  spec.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.test_files = Dir["spec/**/*"]
  spec.add_dependency "rails", "~> 6.1.4"
  spec.add_dependency "the_garage"
  spec.add_development_dependency "rspec-rails"
end
