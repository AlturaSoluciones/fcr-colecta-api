class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.references :place, foreign_key: true
      t.string :direction
      t.string :status
      t.references :responsible, foreign_key: { to_table: :people }

      t.timestamps
    end
  end
end
