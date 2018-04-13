class AddConfirmationTokenToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :confirmation_token, :string
  end
end
