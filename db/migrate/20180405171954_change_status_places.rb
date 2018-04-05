class ChangeStatusPlaces < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        change_column :places, :status, :string, default: 'active', null: false
      end
      dir.down do
        change_column :places, :status, :boolean, default: nil, null: true
      end

    end

  end
end
