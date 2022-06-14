# frozen_string_literal: true

require 'acts_as_graph_diagram/version'
require 'acts_as_graph_diagram/railtie'

module ActsAsGraphDiagram
  autoload :Node, 'acts_as_graph_diagram/node'
  autoload :EdgeScopes, 'acts_as_graph_diagram/edge_scopes.rb'
  require 'acts_as_graph_diagram/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
end
