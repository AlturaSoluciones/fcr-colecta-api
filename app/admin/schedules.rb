ActiveAdmin.register Schedule do
  permit_params :day, :time
  actions :all, except: [:destroy]
end
