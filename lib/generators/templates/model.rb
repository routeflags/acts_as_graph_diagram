# frozen_string_literal: true

# == Schema Information
#
# Table name: edges
#
#  id               :integer          not null, primary key
#  comment          :string           default("")
#  figure           :integer          default(0)
#  lower_figure     :integer          default(0)
#  higher_figure    :integer          default(0)
#  directed         :boolean          default(TRUE)
#  destination_type :string
#  destination_id   :integer
#  departure_type   :string
#  departure_id     :integer
#  created_at       :datetime
#  updated_at       :datetime
#
class Edge < ActiveRecord::Base
  extend ActsAsGraphDiagram::Node
  include ActsAsGraphDiagram::EdgeScopes

  belongs_to :destination, polymorphic: true, optional: true
  belongs_to :departure,   polymorphic: true, optional: true
end
