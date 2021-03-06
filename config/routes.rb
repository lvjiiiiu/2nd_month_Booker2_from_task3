Rails.application.routes.draw do

  get 'chat/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root to: 'home#top'
  get "home/about" => "home#about"
  
  resources :books, except: [:new] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end 
  
  resources :users, except: [:new, :destroy, :create] do
    resource :relationships, only:[:create, :destroy] 
    get '/follows' => 'relationships#follower'
    get '/followers' => 'relationships#followed'
  end
  
  get '/search' => 'search#search'
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
end

