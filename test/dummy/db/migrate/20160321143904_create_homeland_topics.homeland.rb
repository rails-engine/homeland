# This migration comes from homeland (originally 20160321125610)
class CreateHomelandTopics < ActiveRecord::Migration
  def change
    create_table :homeland_topics do |t|
      t.integer :node_id, null: false
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body
      t.text :body_html
      t.integer :last_reply_id
      t.integer :last_reply_user_id
      t.integer :last_active_mark, null: false, default: 0
      t.datetime :replied_at
      t.integer :replies_count, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :homeland_topics, :deleted_at
    add_index :homeland_topics, [:node_id, :deleted_at]
    add_index :homeland_topics, :user_id
    add_index :homeland_topics, [:last_active_mark, :deleted_at]
    add_index :homeland_topics, [:node_id, :last_active_mark]
  end
end
