Rails.application.routes.draw do
  root "home#index"

  scope module: "agencies" do
    resource :dashboard, only: [:show], controller: :dashboard
    resource :profile, only: [:show, :update], controller: :profile do
      resource :password, only: [:update], controller: "profile/password"
    end
    resource :agency, only: [:show, :update], controller: :agency
    resources :clients, except: [:edit]
  end

  devise_for :users, controllers: { registrations: "registrations" }
end
