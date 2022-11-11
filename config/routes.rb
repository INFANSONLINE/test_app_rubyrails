Rails.application.routes.draw do
  resources :users
  resources :articles
root 'pages#home'
get 'about', to: 'pages#about'
get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
get 'logout', to: 'sessions#destroy'


end
