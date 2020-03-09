class AddActiveFlagToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :active, :boolean, null: false, default: true
  end
end
