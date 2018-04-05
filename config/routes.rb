Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get :email_lookup, to: 'api#email_lookup'
      post :personal_data, to: 'api#create_person'
      get :cities, to: 'api#cities'
      get 'places/:id/:status', to: 'api#places'
    end
  end
end
