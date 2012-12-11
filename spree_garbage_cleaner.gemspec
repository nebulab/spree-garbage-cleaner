# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_garbage_cleaner'
  s.version     = '1.1.3'
  s.summary     = 'A little gem that helps you cleanup old, unneeded data from a Spree database.'
  s.description = """
      This spree extensions will help you cleanup old and useless data gathered by spree while you use it,
      like anonymous users and old, incomplete orders.
  """
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'NebuLab'
  s.email     = 'info@nebulab.it'
  s.homepage  = 'http://nebulab.it'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.2.0'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sqlite3'
end
