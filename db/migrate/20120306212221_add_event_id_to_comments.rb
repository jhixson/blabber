class AddEventIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :event_id, :integer
    remove_column :comments, :rating_id
  end
end
