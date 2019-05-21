ActiveAdmin.register Schedule do
  permit_params :day, :time, :kind, :enabled
  actions :all, except: [:destroy]
end
