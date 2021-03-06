Rails.application.routes.draw do
  root 'home#index'

  get       'signup'                => 'users#new'
  get       'profile/edit'          => 'users#edit', as: :edit_user
  resources :users, only: [:index, :show, :create, :update, :destroy]

  get       'login'                 => 'sessions#new'
  post      'login'                 => 'sessions#create'
  delete    'logout'                => 'sessions#destroy'

  get       'blog/:author'          => 'posts#index', as: :blog
  get       'blog/:author/:id'      => 'posts#show', as: :blog_post
  resources :posts, only: [:new, :edit, :create, :update, :destroy]

  post      'blog/:author/:post_id' => 'comments#create'
  resources :comments, only: [:destroy]
end
