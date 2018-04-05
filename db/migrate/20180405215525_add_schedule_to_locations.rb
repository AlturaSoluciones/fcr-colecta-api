class AddScheduleToLocations < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :schedule, foreign_key: true
  end
end
