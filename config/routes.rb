Rails.application.routes.draw do

  root 'home#index'

  get       'signup',           to: 'users#new'
  get       'profile/edit',     to: 'users#edit',     as: :edit_profile
  resources :users, only: [:index, :show, :create, :update, :destroy]

  get       'blog/:author',     to: 'posts#index',    as: :blog
  get       'blog/:author/:id', to: 'posts#show',     as: :blog_post
  resources :posts, only: [:new, :edit, :create, :update, :destroy]

  get       'login',            to: 'sessions#new'
  post      'login',            to: 'sessions#create'
  delete    'logout',           to: 'sessions#destroy'
end
