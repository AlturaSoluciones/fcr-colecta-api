class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :identifier
      t.date :birthday
      t.string :email
      t.string :gender
      t.string :phone
      t.string :cellphone
      t.string :status
      t.references :invited_by#, foreign_key: true
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.references :location#, foreign_key: true

      t.timestamps
    end
  end
end
