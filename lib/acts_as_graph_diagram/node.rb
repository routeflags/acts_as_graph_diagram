# frozen_string_literal: true

require 'acts_as_graph_diagram/node/graph_calculator'

module ActsAsGraphDiagram # :nodoc:
  module Node
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods # :nodoc:
      def acts_as_node
        has_many :behinds, as: :destination,
                           class_name: 'Edge',
                           dependent: :destroy
        has_many :aheads, as: :departure,
                          class_name: 'Edge',
                          dependent: :destroy
        include ActsAsGraphDiagram::Node::InstanceMethods
        include ActsAsGraphDiagram::Node::GraphCalculator
      end
    end

    module InstanceMethods # :nodoc:
      # rubocop:disable Style/HashSyntax

      # Creates a new destination record for this instance to connect the passed object.
      # @param [Node] node
      # @param [String] comment
      # @param [Integer] figure
      # @return [Edge]
      def add_destination(node, comment: '', figure: 0)
        aheads.select_destinations(node)
              .where(comment: comment, figure: figure)
              .first_or_create!
      end

      # Creates a new departure record for this instance to connect the passed object.
      # @param [Node] node
      # @param [String] comment
      # @param [Integer] figure
      # @return [Edge]
      def add_departure(node, comment: '', figure: 0)
        behinds.select_departures(node)
               .where(comment: comment, figure: figure)
               .first_or_create!
      end

      # Creates a new undirected connection record for this instance to connect the passed object.
      # @param [Node] node
      # @param [Boolean] directed
      # @param [String] comment
      # @param [Integer] figure
      # @return [Edge]
      def add_connection(node, directed: false, comment: '', figure: 0)
        Edge.where(destination: node,
                   directed: directed,
                   departure: self,
                   comment: comment,
                   figure: figure).first_or_create!
      end
      # rubocop:enable Style/HashSyntax

      # Returns a destination node record for the current instance.
      # @param [Node] node
      # @return [Edge]
      def get_destination(node)
        aheads.select_destinations(node).first
      end

      # Deletes the destination record if it exists.
      # @param [Node] node
      # @return [Edge|nil]
      def remove_destination(node)
        get_destination(node).try(:destroy)
      end

      # Returns a departure node record for the current instance.
      # @param [Node] node
      # @return [Edge]
      def get_departure(node)
        behinds.select_departures(node).first
      end

      # Deletes the destination record if it exists.
      # @param [Node] node
      # @return [Edge|nil]
      def remove_departure(node)
        get_departure(node).try(:destroy)
      end

      # Returns a undirected node record for the current instance.
      # @param [Node] node
      # @return [Edge]
      def get_connection(node)
        Edge.select_connections(node).first
      end

      # Deletes the undirected record if it exists.
      # @param [Node] node
      # @return [Edge|nil]
      def remove_connection(node)
        get_connection(node).try(:destroy)
      end

      # Returns true if this instance is connecting the object passed as an argument.
      # @param [Node] node
      # @return [Boolean]
      def connecting?(node)
        node.connecting_count.positive?
      end

      # Returns the number of objects this instance is following.
      # @return [Integer]
      def connecting_count
        Edge.select_connections(self).count
      end
    end
  end
end
