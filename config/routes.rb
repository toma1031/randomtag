Rails.application.routes.draw do
  get 'hashtags/create'
  get 'hashtags/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :show, :new, :create, :edit, :update]
    
    
    resources :hashtags, only: [:create, :destroy, :show] 
    # do 
    #   get 'hashtags/randomtag'
    # end
end
