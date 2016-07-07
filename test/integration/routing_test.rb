require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  # home
  test 'home' do
    assert_routing '/', controller: 'home', action: 'index'
  end

  # users
  test 'users#index' do
    assert_routing 'users', controller: 'users', action: 'index'
  end

  test 'users#show' do
    assert_routing 'users/1', controller: 'users', action: 'show', id: '1'
  end

  test 'users#new' do
    assert_routing 'signup', controller: 'users', action: 'new'
  end

  test 'users#edit' do
    assert_routing 'profile/edit', controller: 'users', action: 'edit'
  end

  test 'users#create' do
    assert_routing({ path: 'users', method: :post },
                   controller: 'users', action: 'create')
  end

  test 'users#update' do
    assert_routing({ path: 'users/1', method: :patch },
                   controller: 'users', action: 'update', id: '1')
  end

  test 'users#destroy' do
    assert_routing({ path: 'users/1', method: :delete },
                   controller: 'users', action: 'destroy', id: '1')
  end

  # posts
  test 'posts#index' do
    assert_routing 'blog/test', controller: 'posts', action: 'index',
                   author: 'test'
  end

  test 'posts#show' do
    assert_routing 'blog/test/1', controller: 'posts', action: 'show',
                   author: 'test', id: '1'
  end

  test 'posts#new' do
    assert_routing 'posts/new', controller: 'posts', action: 'new'
  end

  test 'posts#edit' do
    assert_routing 'posts/1/edit', controller: 'posts', action: 'edit', id: '1'
  end

  test 'posts#create' do
    assert_routing({ path: 'posts', method: :post },
                   controller: 'posts', action: 'create')
  end

  test 'posts#update' do
    assert_routing({ path: 'posts/1', method: :patch },
                   controller: 'posts', action: 'update', id: '1')
  end

  test 'posts#destroy' do
    assert_routing({ path: 'posts/1', method: :delete },
                   controller: 'posts', action: 'destroy', id: '1')
  end

  # sessions
  test 'sessions#new' do
    assert_routing 'login', controller: 'sessions', action: 'new'
  end

  test 'sessions#create' do
    assert_routing({ path: 'login', method: 'post' },
                   controller: 'sessions', action: 'create')
  end

  test 'sessions#destroy' do
    assert_routing({ path: 'logout', method: 'delete' },
                   controller: 'sessions', action: 'destroy')
  end
end
