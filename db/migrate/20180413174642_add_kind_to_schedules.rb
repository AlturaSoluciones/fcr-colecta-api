class AddKindToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :kind, :string, null: false
  end
end
