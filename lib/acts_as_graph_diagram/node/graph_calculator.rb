# frozen_string_literal: true

module ActsAsGraphDiagram # :nodoc:
  class NodeList < Array
    def read_tree(functional, meta, value, operator)
      return value if !defined?(empty?) || empty?

      meta[first.destination.read_tree(functional, meta, value, operator),
           ActsAsGraphDiagram::NodeList.new(tail)
                                       .read_tree(functional, meta, value, operator)]
    end

    def linear(functional, value)
      return self if empty? || !first.attributes.include?(:destination)

      functional[first.destination,
                 ActsAsGraphDiagram::NodeList.new(tail)
                                             .linear(functional, value)]
    end

    def tail
      drop 1
    end

    def confluence
      lambda do |x, list = self|
        ActsAsGraphDiagram::NodeList.new([x] + list)
      end
    end

    def append
      lambda do |nodes = self, list|
        nodes.linear confluence,
                     ActsAsGraphDiagram::NodeList.new(list)
      end
    end
  end

  module Node # :nodoc:
    module GraphCalculator
      extend ActiveSupport::Concern

      included do
        def read_tree(functional, meta, value, operator = :self)
          if operator == :self
            functional[self,
                       ActsAsGraphDiagram::NodeList.new(departures.to_a)
                                                   .read_tree(functional, meta, value, operator)]
          else
            functional[public_send(operator),
                       ActsAsGraphDiagram::NodeList.new(departures.to_a)
                                                   .read_tree(functional, meta, value, operator)]
          end
        end

        # @return Integer
        def sum_tree_cost
          read_tree addition, addition, 0, :sum_cost
        end

        def addition
          ->(x, y) { x + y }
        end

        def sum_cost
          departures.sum(:cost)
        end

        def linear(functional, meta)
          ->(x, y) { functional[meta[x], y] }
        end

        def append
          lambda do |node = self, list|
            node.linear confluence,
                        ActsAsGraphDiagram::NodeList.new(list)
          end
        end

        def confluence
          lambda do |x, nodes = self|
            ActsAsGraphDiagram::NodeList.new([x] + nodes)
          end
        end

        # @return [Node]
        def assemble_nodes
          read_tree confluence, append, []
        end
      end
    end
  end
end
