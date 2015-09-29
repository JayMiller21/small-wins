Rails.application.routes.draw do

  get 'welcome/index'
  root 'welcome#index'

  devise_for :users
  get 'sessions/create'
  get 'sessions/destroy'
  get '/welcome' => "welcome#index", as: :user_root

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :users, only: [] do
    resources :habits do
      member do
        post 'create_completed_day'
      end
    end
  end
  resources :completed_days 

end
