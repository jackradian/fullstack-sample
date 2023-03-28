Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :v1 do
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    post "login/refresh", to: "sessions#refresh"
    resources :movies, only: [:index, :create] do
      get "my_list", on: :collection
      member do
        put "upvote", to: "votes#upvote"
        put "downvote", to: "votes#downvote"
        delete "remove_vote", to: "votes#remove"
      end
    end
  end
end
