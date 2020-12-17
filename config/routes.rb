Rails.application.routes.draw do
  devise_for :users
  root to: 'home#top'
  get "home/about" => "home#about"
  resources :books, except: [:new]
  resources :users, except: [:new, :destroy, :create]
end
