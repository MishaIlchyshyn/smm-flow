Rails.application.routes.draw do
  root "home#index"

  scope module: "agencies" do
    resource :profile, only: [:show, :update], controller: :profile do
      resource :password, only: [:update], controller: "profile/password"
    end

    resources :clients, except: [:edit]
  end

  devise_for :users, controllers: { registrations: "registrations" }
end
