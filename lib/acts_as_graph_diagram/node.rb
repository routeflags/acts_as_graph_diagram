# frozen_string_literal: true

module ActsAsGraphDiagram # :nodoc:
  module Node
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods # :nodoc:
      def acts_as_node
        has_many :destinations, as: :destination, class_name: 'Edge'
        has_many :departures, as: :departure, class_name: 'Edge'
        include ActsAsGraphDiagram::Node::InstanceMethods
      end
    end

    module InstanceMethods # :nodoc:
      # Creates a new destination record for this instance to connect the passed object.
      # @param [Node] node
      # @return [Edge]
      def add_destination(node)
        departures.select_destinations(node).first_or_create!
      end

      # Creates a new departure record for this instance to connect the passed object.
      # @param [Node] node
      # @return [Edge]
      def add_departure(node)
        destinations.select_departures(node).first_or_create!
      end

      # Creates a new undirected connection record for this instance to connect the passed object.
      # @param [Node] node
      # @return [Edge]
      def add_connection(node)
        Edge.where(destination: node, directed: false, departure: self).first_or_create!
      end

      # Returns a destination node record for the current instance.
      # @param [Node] node
      # @return [Edge]
      def get_destination(node)
        departures.select_destinations(node).first
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
        destinations.select_departures(node).first
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
        Edge.select_destinations(self).count + Edge.select_departures(self).count
      end
    end
  end
end
