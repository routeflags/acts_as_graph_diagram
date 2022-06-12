# frozen_string_literal: true

# == Schema Information
#
# Table name: gods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class God < ActiveRecord::Base
  acts_as_node
end
