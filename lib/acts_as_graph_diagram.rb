# frozen_string_literal: true

require 'acts_as_graph_diagram/version'
require 'acts_as_graph_diagram/railtie'

module ActsAsGraphDiagram
  autoload :Node, 'acts_as_graph_diagram/node'
  autoload :GraphDiagramScopes, 'acts_as_graph_diagram/graph_diagram_scopes'
  require 'acts_as_graph_diagram/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
end
