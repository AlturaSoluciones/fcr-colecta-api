ActiveAdmin.register Person do
  permit_params :firstname, :lastname, :identifier, :birthday, :email, :gender,
                :phone, :cellphone, :status, :invited_by_id, :confirmation_token,
                :confirmed_at, :location

  index do
    selectable_column
    column "Firstname", :firstname
    column "Lastname", :lastname
    column "Identifier", :identifier
    column "Birthday", :birthday
    column "Email", :email
    column "Gender", :gender
    column "Phone", :phone
    column "Cellphone", :cellphone
    column "Status", :status
    column "Leader", :invited_by_id
    column "Confirmation token", :confirmation_token
    column "Confirmed at", :confirmed_at
    column :place do |p|
      p.assigned_location ? p.assigned_location.place.name : "No place confirmed yet"
    end
    actions
  end
end
