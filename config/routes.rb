Rails.application.routes.draw do
  root "welcome#index"

  get "auth/twitter",as: :login
  get "auth/twitter/callback" =>  "sessions#create"

  get "dashboard", to: "dashboard#show"

  post "tweets", to: "tweets#create"
  post "favorites", to: "tweets#favorite"

  get "logout" => "sessions#destroy", as: :logout
end
