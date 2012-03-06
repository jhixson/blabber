class RemoveCommentIdFromRatings < ActiveRecord::Migration
  def up
    remove_column :ratings, :comment_id
  end

  def down
    add_column :ratings, :comment_id, :integer
  end
end
