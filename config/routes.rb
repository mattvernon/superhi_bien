Rails.application.routes.draw do

    resources :reviews do
      resources :comments
    end

    resources :users

    resources :sessions

    root "reviews#index"


end
