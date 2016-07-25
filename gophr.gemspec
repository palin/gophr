require_relative 'lib/gophr/version'

Gem::Specification.new do |s|
  s.name        = 'gophr'
  s.version     = Gophr::VERSION
  s.date        = '2016-07-25'
  s.summary     = "GOPHR Commercial API wrapper"
  s.description = "Allows you to use GOPHR Commercial API without hassle."
  s.authors     = ["Maciej Paliński"]
  s.email       = 'maciekpalinski@gmail.com'
  s.require_path = 'lib'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/palin/gophr'
  s.add_runtime_dependency 'httparty', '~> 0.13', '>= 0.13.7'
  s.add_development_dependency "rspec", "~> 3.0"
  s.license     = 'MIT'
end
