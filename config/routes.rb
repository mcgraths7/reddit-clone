Rails.application.routes.draw do
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
