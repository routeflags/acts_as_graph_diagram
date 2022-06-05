# frozen_string_literal: true

class Edge < ActiveRecord::Base
  extend ActsAsGraphDiagram::Node
  include ActsAsGraphDiagram::GraphDiagramScopes

  belongs_to :destination, polymorphic: true, optional: true
  belongs_to :departure,   polymorphic: true, optional: true
end
