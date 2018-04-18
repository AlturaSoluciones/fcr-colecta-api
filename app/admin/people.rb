ActiveAdmin.register Person do
  permit_params :firstname, :lastname, :identifier, :birthday, :email, :gender,
                :phone, :cellphone, :status, :invited_by_id, :confirmation_token,
                :confirmed_at, :location

  includes :invited_by, :friends, location: :place

  scope 'Todos', :all, default: true
  scope 'Líderes', :leaders
  scope 'Confirmados', :confirmed
  scope 'Pendientes', :pending

  index do
    selectable_column
    column :firstname
    column :lastname
    column :identifier
    column :birthday
    column :email
    column :gender
    column :phone
    column :cellphone
    column "Confirmado?" do |p|
      p.confirmed? ? status_tag('Confirmado', class: 'green') : status_tag('Pendiente', class: 'red')
    end
    column "Es Líder?" do |p|
      p.is_leader? ? status_tag("Líder", class: 'green') : status_tag("Miembro", class: 'orange')
    end
    column :leader
    column "Equipo" do |p|
      p.friends.each do |f|
        div f.display_name, class: 'no-wrap'
      end
      text_node "&nbsp;".html_safe
    end
    column :confirmation_token
    column :confirmed_at
    column :place do |p|
      div(p.assigned_location ? p.assigned_location.display_name : "Sin ubicación", class: 'no-wrap')
    end
    actions
  end
end
