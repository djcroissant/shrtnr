Rails.application.routes.draw do
  get 'dashboard' => 'dashboards#index', :as => :dashboard
  get 'home' => 'dashboards#home', :as => :home

  get 'login' => 'sessions#new', :as => :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', :as => :logout

  resources :users, only: [:new, :create]
  get '/settings' => 'settings#index', :as => :settings
  post '/settings' => 'settings#update'

  resources :links, only: [:create, :show, :redirection, :destroy]

  get '/:id' => 'links#redirection', :as => :redirect_url

  root 'sessions#direct'

  #This is added for Omniauth.  Will need to update once I get started
  #looking at the Twitter specific documentation
  get '/auth/:provider/callback', to: 'sessions#create_twitter'
end
