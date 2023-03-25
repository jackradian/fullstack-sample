Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :v1 do
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    post "login/refresh", to: "sessions#refresh"
  end
end
