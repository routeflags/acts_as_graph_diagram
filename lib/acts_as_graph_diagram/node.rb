# frozen_string_literal: true

module ActsAsGraphDiagram # :nodoc:
  module Node
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_node
        has_many :destinations, as: :destination, class_name: 'Edge'
        has_many :departures, as: :departure, class_name: 'Edge'
        include ActsAsGraphDiagram::Node::InstanceMethods
      end
    end

    module InstanceMethods
      # Creates a new destination record for this instance to connect the passed object.
      # Does not allow duplicate records to be created.
      def add_destination(node)
        return if self == node

        departures.select_destinations(node).first_or_create!
      end

      # Creates a new departure record for this instance to connect the passed object.
      # Does not allow duplicate records to be created.
      def add_departure(node)
        return if self == node

        destinations.select_departures(node).first_or_create!
      end

      # Returns a node record for the current instance.
      def get_destination(node)
        departures.select_destinations(node).first
      end

      # Deletes the destination record if it exists.
      def remove_destination(node)
        get_destination(node).try(:destroy)
      end

      # Returns a node record for the current instance.
      def get_departure(node)
        destinations.select_departures(node).first
      end

      # Deletes the destination record if it exists.
      def remove_departure(node)
        get_departure(node).try(:destroy)
      end

      # Returns true if this instance is connecting the object passed as an argument.
      def connecting?(node)
        node.connecting_count.positive?
      end

      # Returns the number of objects this instance is following.
      def connecting_count
        Edge.select_destinations(self).count + Edge.select_departures(self).count
      end
    end
  end
end
