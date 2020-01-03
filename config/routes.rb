Rails.application.routes.draw do
  root to:'home#index'
  get '/about', to:'home#index'
  get '/contact', to:'home#index'
  get '/show', to:'hoge#index'

  namespace :api, format: 'json' do
    resources :tasks, only:[:index, :create, :update, :show]
  end
end
