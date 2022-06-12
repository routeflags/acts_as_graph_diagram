# frozen_string_literal: true

require 'test_helper'

class ActsAsGraphDiagramTest < ActiveSupport::TestCase
  test 'it has a version number' do
    assert ActsAsGraphDiagram::VERSION
  end

  test 'be defined' do
    assert God.first.respond_to?(:destinations)
    assert God.first.respond_to?(:departures)
    assert God.first.respond_to?(:add_destination)
    assert God.first.respond_to?(:add_departure)
    assert God.first.respond_to?(:get_destination)
    assert God.first.respond_to?(:get_departure)
    assert God.first.respond_to?(:remove_destination)
    assert God.first.respond_to?(:remove_departure)
    assert God.first.respond_to?(:connecting?)
    assert God.first.respond_to?(:connecting_count)
    assert God.first.respond_to?(:add_connection)
  end
end
