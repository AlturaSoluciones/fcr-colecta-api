class AddEnabledFlagToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :enabled, :boolean, null: false, default: true
  end
end
