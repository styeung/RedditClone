Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy]

  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new, :create]
    resources :votes, only: [:create]
  end

  resources :comments, only: [:destroy] do
    resources :comments, only: [:new, :create]
    resources :votes, only: [:create]
  end

  resources :votes, only: [:destroy]

end

