ActiveAdmin.register Schedule do
  permit_params :day, :time, :kind
  actions :all, except: [:destroy]
end
