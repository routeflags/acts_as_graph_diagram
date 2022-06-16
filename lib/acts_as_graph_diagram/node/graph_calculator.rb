# frozen_string_literal: true

module ActsAsGraphDiagram # :nodoc:
  ##
  # This module represents a array of node.
  class Nodes < Array
    # @param [Proc] functional
    # @param [Proc] meta
    # @param [Array] values
    # @param [Symbol] operator
    # @return Proc
    def read_tree(functional, meta, values, operator)
      return values if !defined?(empty?) || empty?

      meta[first.destination.read_tree(functional, meta, values, operator),
           ActsAsGraphDiagram::Nodes.new(tail)
                                    .read_tree(functional, meta, values, operator)]
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
        # @return Proc
        def read_tree(functional, meta, value, operator = :self)
          argument = if operator == :self
                  self
                else
                  public_send(operator)
                end
          functional[argument,
                     ActsAsGraphDiagram::Nodes
                       .new(aheads.where.not(destination_id: id).to_a)
                       .read_tree(functional, meta, value, operator)]
        end

        # @return Integer
        def sum_tree_cost
          read_tree addition, addition, 0, :sum_cost
        end

        # @return Proc
        def addition
          # @param [Any] x
          # @param [Any] y
          ->(x, y) { x + y }
        end

        def sum_cost
          aheads.sum(:cost)
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
          read_tree confluence, append, []
        end
      end
    end
  end
end
