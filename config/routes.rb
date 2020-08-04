Rails.application.routes.draw do
  resources :posts do
    get 'comments/new' => 'comments#new', as: 'new_comment'
  end
  resources :comments, only: [:create, :show, :edit, :destroy]
  get 'feed' => 'posts#feed'
  
  # Rename url for "topics" as "/t/:id"
  get 't' => 'topics#index', as: 'all_topics'
  post 't' => 'topics#create', as: 'topics'
  get 't/new' => 'topics#new', as: 'new_topic'
  get 't/:id/edit' => 'topics#edit', as: 'edit_topic'
  get 't/:id' => 'topics#show', as: 'show_topic'
  patch 't/:id' => 'topics#update', as: 'update_topic'
  delete 't/:id' => 'topics#destroy', as: 'destroy_topic'
  get 't/:id/subscribe' => 'topics#subscribe', as: 'subscribe'
  get 't/:id/unsubscribe' => 'topics#unsubscribe', as: 'unsubscribe'

  # Rename url for "users" as "/u/:id"
  get 'u' => 'user#index', as: 'all_users'
  get 'u/:id/edit' => 'users#edit', as: 'edit_user'
  get 'u/:id' => 'users#show', as: 'show_user'
  patch 'u/:id' => 'users#update', as: 'update_user'
  delete 'u/:id' => 'users#destroy', as: 'destroy_tuser'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  
  get 'vote' => 'votes#vote'

  root to: 'posts#feed'
end
