class Edge < ActiveRecord::Base

  extend ActsAsGraphDiagram::Node

  belongs_to :destination, polymorphic: true
  belongs_to :departure,   polymorphic: true

end
