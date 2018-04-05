class AddDefaultStatusToLocations < ActiveRecord::Migration[5.1]
  def change
    change_column_default :locations, :status, from: nil, to: 'reserved'
    change_column_null :locations, :status, false
  end
end
