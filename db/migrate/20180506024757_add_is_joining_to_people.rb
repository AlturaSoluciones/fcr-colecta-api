class AddIsJoiningToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :is_joining, :boolean, default: false, null: false
  end
end
