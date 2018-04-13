class RemoveLocationFromPeople < ActiveRecord::Migration[5.1]
  def change
    remove_column :people, :location_id, :bigint
  end
end
