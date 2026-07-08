Rails.application.routes.draw do
  root "home#index"

  scope module: "agencies" do
    resource :dashboard, only: [:show], controller: :dashboard
    resource :agency, only: [:show, :update], controller: :agency

    resource :profile, only: [:show, :update], controller: :profile do
      resource :password, only: [:update], controller: "profile/password"
    end

    resources :clients, except: [:edit] do
      resources :projects, except: [:edit], controller: "clients/projects"
    end
    resources :projects, except: [:edit]
  end

  devise_for :users, controllers: { registrations: "registrations" }
end
