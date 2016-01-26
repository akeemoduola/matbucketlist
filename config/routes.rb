Rails.application.routes.draw do
  resources :bucketlists do
    resources :items, only: [:create, :update, :destroy]
  end
  post 'auth/login'

  get 'auth/logout'

  resources :users, :only => ["create"]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
