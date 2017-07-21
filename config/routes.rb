Rails.application.routes.draw do
  
  root 'forecast#index'

  resources :forecast
  resources :api
end
