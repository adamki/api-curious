Rails.application.routes.draw do
  root "welcome#index"

  get "auth/twitter",as: :login
  get "auth/twitter/callback" =>  "sessions#create"

  get "logout" => "sessions#destroy", as: :logout

end
