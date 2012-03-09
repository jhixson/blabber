class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :college
      t.text :comment_text

      t.timestamps
    end
  end
end
