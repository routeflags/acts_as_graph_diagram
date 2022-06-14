# frozen_string_literal: true

require_relative 'lib/acts_as_graph_diagram/version'

Gem::Specification.new do |spec|
  spec.name        = 'acts_as_graph_diagram'
  spec.version     = ActsAsGraphDiagram::VERSION
  spec.authors     = ['smapira']
  spec.email       = ['smapira@routeflags.com']
  spec.homepage    = 'https://github.com/smapira/acts_as_graph_diagram'
  spec.summary     = 'Draws a graph diagram from a active record model'
  spec.description = <<-DESCRIPTION
    Extends Active Record to add simple function for draw the Force Directed Graph with html.
  DESCRIPTION
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/smapira/acts_as_graph_diagram'
  spec.metadata['changelog_uri'] = 'https://github.com/smapira/acts_as_graph_diagram/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  spec.add_dependency 'activerecord', '>= 4.0'

  spec.add_development_dependency 'annotate'
  spec.add_development_dependency 'better_errors'
  spec.add_development_dependency 'binding_of_caller'
  spec.add_development_dependency 'importmap-rails'
  spec.add_development_dependency 'listen'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'puma'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'seed_dump'
  spec.add_development_dependency 'sprockets-rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'turbo-rails'
  spec.add_development_dependency 'web-console'
end
