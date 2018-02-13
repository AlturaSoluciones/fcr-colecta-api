class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.references :city, foreign_key: true
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.boolean :status

      t.timestamps
    end
  end
end
