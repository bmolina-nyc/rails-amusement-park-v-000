Rails.application.routes.draw do
  resources :sessions, only:[:new, :show, :create]

  get '/signin' => 'sessions#new'

  root 'static#root'

  post "/logout" => "sessions#destroy", as: :logout

  resources :users



end