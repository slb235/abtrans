Rails.application.routes.draw do

  resources :projects do
    resources :languages do
      resources :translations
    end
    resources :terms
  end
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
