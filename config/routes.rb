Rails.application.routes.draw do
  namespace :v1 do
    jsonapi_resources :users, except: [:destroy]
    jsonapi_resources :wines
    jsonapi_resources :shares
  end
end
