# This migration comes from homeland (originally 20160321125920)
class CreateHomelandReplies < ActiveRecord::Migration
  def change
    create_table :homeland_replies do |t|
      t.integer :user_id
      t.integer :topic_id
      t.text :body
      t.text :body_html
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :homeland_replies, :user_id
    add_index :homeland_replies, :topic_id
  end
end
