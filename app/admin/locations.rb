ActiveAdmin.register Location do
  permit_params :place_id, :direction, :status, :responsible_id, :schedule_id
end
