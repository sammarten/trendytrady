Rails.application.routes.draw do
  resources :periods
  resources :quotes
  
  root :to => 'securities#index'
  get "securities" => "securities#index"
  get "securities/:id" => "securities#show", as: "security"
end
