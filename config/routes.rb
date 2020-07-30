Rails.application.routes.draw do
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :topics, except: [:index]
  resources :posts, except: [:index] do
    get 'comments/new' => 'comments#new', as: 'new_comment'
  end
  resources :comments, only: [:create, :show, :edit, :destroy]
  get 'feed' => 'topics#index'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
