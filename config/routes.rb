Rails.application.routes.draw do
  root "home#index"

  scope module: "agencies" do
    resource :dashboard, only: [:show], controller: :dashboard
  end

  devise_for :users, controllers: { registrations: "registrations" }
end
