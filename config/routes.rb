Rails.application.routes.draw do
  post 'auth/login'

  get 'auth/logout'

  resources :users, :only => ["create"]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
