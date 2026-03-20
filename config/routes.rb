Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  resources :registrations, only: [ :create ]
  resource :intake, only: [ :show, :update ]
  resource :customer, only: [ :show ]

  namespace :admin do
    resources :customers, only: [ :index, :show, :edit, :update, :destroy ] do
      collection do
        delete :batch_destroy
        delete :batch_hard_destroy
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
