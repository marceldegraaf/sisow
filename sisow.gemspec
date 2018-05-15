# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sisow/version"

Gem::Specification.new do |s|
  s.name        = "sisow"
  s.version     = Sisow::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marcel de Graaf"]
  s.email       = ["mail@marceldegraaf.net"]
  s.homepage    = "http://github.com/marceldegraaf/sisow"
  s.summary     = %q{Rails gem for payments through Sisow.}
  s.description = %q{This gem implements the REST API of the Sisow payment provider.}

  s.rubyforge_project = "sisow"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'httpi', '~> 2'
  s.add_dependency 'hashie', '~> 3'
  s.add_dependency 'crack', '~> 0.4'

  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'vcr', '~> 4'
  s.add_development_dependency 'webmock', '~> 3'
  s.add_development_dependency 'simplecov', '~> 0.16'
  s.add_development_dependency 'simplecov-rcov', '~> 0.2'
  s.add_development_dependency 'dotenv', '~> 2'

end
