Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/restaurants", to: "restaurants#index"
  get "/restaurants/new", to: "restaurants#new"
  post "/restaurants", to: "restaurants#create"
  get "/restaurants/:id/cooks/new", to: "cooks#new"
  post "/restaurants/:id/cooks", to: "cooks#create"
  get "/cooks/:id/edit", to: "cooks#edit"
  patch "/cooks/:id", to: "cooks#update"
  get "/restaurants/:id/edit", to: "restaurants#edit"
  patch "/restaurants/:id", to: "restaurants#update"
  get "/restaurants/:id", to: "restaurants#show"
  get "/cooks", to: "cooks#index"
  get "/cooks/:id", to: "cooks#show"
  get "/restaurants/:id/cooks", to: "restaurants#cooks"

  # Defines the root path route ("/")
  # root "posts#index"
end
