# This migration comes from homeland (originally 20160321125035)
class CreateHomelandNodes < ActiveRecord::Migration
  def change
    create_table :homeland_nodes do |t|
      t.string :name, null: false
      t.string :description
      t.string :color
      t.integer :sort, default: 0, null: false
      t.integer :topics_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :homeland_nodes, 'sort'
  end
end
