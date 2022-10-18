Rails.application.routes.draw do
  resources :users, except: [:new]
  resources :articles
root 'pages#home'
get 'about', to: 'pages#about'
get 'login', to: 'users#new'

end
