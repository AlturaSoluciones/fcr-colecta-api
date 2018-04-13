class AddConfirmedAtToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :confirmed_at, :timestamp
  end
end
