class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.date :day
      t.string :time

      t.timestamps
    end
  end
end
