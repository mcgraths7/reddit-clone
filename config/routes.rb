Rails.application.routes.draw do
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :topics, except: [:index]
  resources :posts, except: [:index] do
    get 'comments/new' => 'comments#new', as: 'new_comment'
  end
  resources :comments, only: [:create, :show, :edit, :destroy]
  get 'feed' => 'posts#feed'
  get 'topics/:id/subscribe' => 'topics#subscribe', as: 'subscribe'
  get 'topics/:id/unsubscribe' => 'topics#unsubscribe', as: 'unsubscribe'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'posts/:id/upvote' => 'posts#upvote', as: 'upvote_post'
  get 'posts/:id/downvote' => 'posts#downvote', as: 'downvote_post'
  get 'comments/:id/upvote' => 'comments#upvote', as: 'upvote_comment'
  get 'comments/:id/downvote' => 'comments#downvote', as: 'downvote_comment'

  root to: 'posts#feed'
end
