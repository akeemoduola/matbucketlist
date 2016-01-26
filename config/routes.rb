Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'}, constraints: {}, path: '/' do
    scope module: :v1,
                  constraints: ApiConstraints.new(version: 1, default: true) do
      resources :bucketlists do
        resources :items, only: [:create, :update, :destroy]
      end
      post 'auth/login'
      get 'auth/logout'
      resources :users, :only => ["create"]
    end
  end
end
