Rails.application.routes.draw do
  
  root 'forecast#index'

  post '/api',     to: 'api#create',     as: :api_create
  get '/forecast', to: 'forecast#index', as: :forecast_index

end
