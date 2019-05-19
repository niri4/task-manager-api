Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:new, :create, :edit, :update, :index, :show, :destroy]
      resources :users, only: [:create, :index, :new, :update]
      resources :labels, only: [:new, :create, :edit, :update, :index]
    end
  end
  post 'authenticate', to: 'authentication#authenticate'
end
