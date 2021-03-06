# frozen_string_literal: true

require 'test_helper'

class ActsAsGraphDiagramTest < ActiveSupport::TestCase
  test 'it has a version number' do
    assert ActsAsGraphDiagram::VERSION
  end

  test 'be defined' do
    assert God.first.respond_to?(:aheads)
    assert God.first.respond_to?(:behinds)
    assert God.first.respond_to?(:add_destination)
    assert God.first.respond_to?(:add_departure)
    assert God.first.respond_to?(:get_destination)
    assert God.first.respond_to?(:get_departure)
    assert God.first.respond_to?(:remove_destination)
    assert God.first.respond_to?(:remove_departure)
    assert God.first.respond_to?(:connecting?)
    assert God.first.respond_to?(:connecting_count)
    assert God.first.respond_to?(:add_connection)
    assert God.first.respond_to?(:sum_tree)
    assert God.first.respond_to?(:assemble_tree_nodes)
  end

  test 'calculate sum_tree' do
    God.find(4).add_destination(God.find(6), figure: 4)
    God.find(6).add_destination(God.find(7), figure: 3)
    assert_equal God.find(4).sum_tree(:figure), 7
  end

  test 'call assemble_tree_nodes' do
    God.find(4).add_destination(God.find(6), figure: 4)
    God.find(6).add_destination(God.find(7), figure: 3)
    God.find(6).add_destination(God.find(7), figure: 3)
    assert_equal God.find(4).assemble_tree_nodes.size, 3
  end
end
