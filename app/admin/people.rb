ActiveAdmin.register Person do
  permit_params :firstname, :lastname, :identifier, :birthday, :email, :gender,
                :phone, :cellphone, :status, :invited_by_id, :confirmation_token,
                :confirmed_at
end
