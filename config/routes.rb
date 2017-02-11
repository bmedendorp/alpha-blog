Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'download', to: 'pages#download'
  get 'contact', to: 'pages#contact'

  resources :articles

  get   '/login', :to => 'sessions#new', :as => :login
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
end
