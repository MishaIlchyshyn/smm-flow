Rails.application.routes.draw do
  root "home#index"

  scope module: "agencies" do
    resource :profile, only: [:show, :update], controller: :profile do
      resource :password, only: [:update], controller: "profile/password"
    end

    resources :clients, except: [:edit] do
      resources :projects, except: [:edit], controller: "clients/projects"
    end
    resources :projects, except: [:edit] do
      resource :brand_positioning, only: [:update], controller: "projects/brand_positionings"
      resources :content_plan_items, except: [:edit], controller: "projects/content_plan_items"
    end
  end

  devise_for :users, controllers: { registrations: "registrations" }
end
