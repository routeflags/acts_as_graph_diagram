# frozen_string_literal: true

module ActsAsGraphDiagram # :nodoc:
  ##
  # This module represents a array of node.
  class Nodes < Array
    # @param [Proc] functional
    # @param [Proc] meta
    # @param [Any] value
    # @param [Symbol] operator
    # @return Any
    def recurse_apply(functional, meta, value, operator)
      return value if !defined?(empty?) || empty?

      meta[
        first.destination.recurse_apply(functional, meta, value, operator),
        ActsAsGraphDiagram::Nodes.new(tail)
                                 .recurse_apply(functional, meta, value, operator)
      ]
    end

    # @param [Proc] functional
    # @param [Nodes] values
    # @return Proc
    def linear(functional, values)
      return self if empty? || !first.attributes.include?(:destination)

      functional[first.destination,
                 ActsAsGraphDiagram::Nodes.new(tail)
                                          .linear(functional, values)]
    end

    # @return Array
    def tail
      drop 1
    end

    # @return Proc
    def confluence
      # @param [Proc] functional
      # @param [Nodes] values
      lambda do |x, list = self|
        ActsAsGraphDiagram::Nodes.new([x] + list)
      end
    end

    # @return Proc
    def append
      # @param [Proc] functional
      # @param [Nodes] values
      lambda do |nodes = self, list|
        nodes.linear confluence,
                     ActsAsGraphDiagram::Nodes.new(list)
      end
    end
  end

  module Node # :nodoc:
    ##
    # This module represents a calculation of graph.
    module GraphCalculator
      extend ActiveSupport::Concern

      included do
        # @param [Proc] functional
        # @param [Proc] meta
        # @param [Any] value
        # @param [Symbol] operator
        # @return Any
        def recurse_apply(functional, meta, value, operator = :self)
          argument = if operator == :self
                       self
                     else
                       public_send(operator[0]).public_send(operator[1], operator[2])
                     end

          functional[argument,
                     ActsAsGraphDiagram::Nodes
                       .new(aheads.where.not(destination_id: id).to_a)
                       .recurse_apply(functional, meta, value, operator)]
        end

        # @return Integer
        def sum_tree(column = :figure)
          recurse_apply addition, addition, 0, %i[aheads sum] + [column]
        end

        # @return Proc
        def addition
          # @param [Integer] x
          # @param [Integer] y
          # @return Integer
          ->(x, y) { x + y }
        end

        # @param [Proc] functional
        # @param [Proc] meta
        # @return Proc
        def linear(functional, meta)
          raise NotImplementedError
          ->(x, y) { functional[meta[x], y] }
        end

        # @return Proc
        def append
          # @param [Nodes] nodes
          # @param [Array] values
          lambda do |nodes = self, values|
            nodes.linear confluence, ActsAsGraphDiagram::Nodes.new(values)
          end
        end

        # @return Proc
        def confluence
          # @param [Node] node
          # @param [Nodes] nodes
          lambda do |node, nodes = self|
            ActsAsGraphDiagram::Nodes.new([node] + nodes)
          end
        end

        # @return [Node]
        def assemble_tree_nodes
          recurse_apply confluence, append, []
        end
      end
    end
  end
end
