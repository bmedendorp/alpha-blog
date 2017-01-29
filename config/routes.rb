Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'download', to: 'pages#download'
  get 'contact', to: 'pages#contact'
end
