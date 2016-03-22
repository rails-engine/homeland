class AddReplyToIdToReplies < ActiveRecord::Migration
  def change
    add_column :homeland_replies, :reply_to_id, :integer

    add_index :homeland_replies, :reply_to_id
  end
end
