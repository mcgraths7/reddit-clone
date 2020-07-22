Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
