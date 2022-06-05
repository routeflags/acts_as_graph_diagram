# frozen_string_literal: true

class CreateGods < ActiveRecord::Migration[6.1]
  def change
    create_table :gods do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
