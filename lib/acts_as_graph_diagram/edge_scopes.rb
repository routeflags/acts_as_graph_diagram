# frozen_string_literal: true

module ActsAsGraphDiagram # :nodoc:
  module EdgeScopes
    extend ActiveSupport::Concern

    included do
      # returns Edge records where destination is the record passed in.
      # @param [Node] node
      scope :select_destinations, ->(node) { where(destination_id: node.id, destination_type: node.class.name) }

      # returns Edge records where departure is the record passed in.
      # @param [Node] node
      scope :select_departures, ->(node) { where(departure_id: node.id, departure_type: node.class.name) }

      # returns Edge records where departure or destination are the record passed in.
      # @param [Node] node
      scope :select_connections, ->(node) { select_destinations(node).or(select_departures(node)) }
    end
  end
end
