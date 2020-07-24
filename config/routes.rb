Rails.application.routes.draw do
  root to: 'users#index'
  
  get 'hashtags/create'
  get 'hashtags/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'hashtags/index'
  post 'hashtags/index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users
  
  
  resources :hashtags, only: [:create, :destroy, :show] 

end
