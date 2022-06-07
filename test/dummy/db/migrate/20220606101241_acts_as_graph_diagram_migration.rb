# frozen_string_literal: true

class ActsAsGraphDiagramMigration < ActiveRecord::Migration[4.2]
  def self.up
    create_table :edges, force: true do |t|
      t.string :note, default: ''
      t.integer :cost, default: 0
      t.boolean :directed, default: true
      t.references :destination, polymorphic: true, null: true
      t.references :departure, polymorphic: true, null: true
      t.timestamps
    end

    add_index :edges, %w[departure_id departure_type], name: 'fk_edges_departure'
    add_index :edges, %w[destination_id destination_type], name: 'fk_edges_destination'
  end

  def self.down
    drop_table :edges
  end
end
