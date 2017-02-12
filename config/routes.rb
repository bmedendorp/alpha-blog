Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'download', to: 'pages#download'
  get 'contact', to: 'pages#contact'

  resources :articles

  get '/auth/login', :to => 'authorizations#new'
  get '/auth/:provider/callback', :to => 'authorizations#create'
  get '/auth/failure', :to => 'authorizations#failure'
end
