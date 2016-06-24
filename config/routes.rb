Rails.application.routes.draw do

  root 'home#index'

  get     'signup',                   to: 'users#new'
  get     'profile/edit',             to: 'users#edit',     as: :edit_profile
  patch   'profile',                  to: 'users#update',   as: :update_profile
  delete  'profile',                  to: 'users#destroy',  as: :delete_profile
  resources :users, only: [:index, :show, :create]

  get     'posts/:author',           to: 'posts#index',    as: :posts
  get     'posts/:author/:id',       to: 'posts#show',     as: :post
  get     'new',                     to: 'posts#new',      as: :new_post
  get     'edit/:id',                to: 'posts#edit',     as: :edit_post
  post    'posts',                   to: 'posts#create',   as: :create_post
  patch   'posts/:id',               to: 'posts#update',   as: :update_post
  delete  'posts/:id',               to: 'posts#destroy',  as: :delete_post

end
