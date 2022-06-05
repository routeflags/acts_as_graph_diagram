# frozen_string_literal: true

module ActsAsGraphDiagram # :nodoc:
  module GraphDiagramScopes
    extend ActiveSupport::Concern

    included do
      # returns Follow records where destination is the record passed in.
      scope :select_destinations, ->(node) { where(destination_id: node.id, destination_type: node.class.name) }

      # returns Follow records where departure is the record passed in.
      scope :select_departures, ->(node) { where(departure_id: node.id, departure_type: node.class.name) }
    end
  end
end
