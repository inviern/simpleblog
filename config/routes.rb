Rails.application.routes.draw do

  root 'home#index'

  get     'signup',                   to: 'users#new'
  get     'profile/edit',             to: 'users#edit',     as: :edit_profile
  patch   'profile',                  to: 'users#update',   as: :update_profile
  delete  'profile',                  to: 'users#destroy',  as: :delete_profile
  resources :users, only: [:index, :show, :create]

  get     'blog/:author',           to: 'posts#index',    as: :blog
  get     'blog/:author/:id',       to: 'posts#show',     as: :blog_post
  resources :posts, only: [:new, :edit, :create, :update, :destroy]
end
