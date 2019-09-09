Rails.application.routes.draw do
  devise_for :users
  root to: 'communities#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # action cabel (chat)
  # mount ActionCable.server => "/cable"

  post 'communities/:id', to: 'communities#join_community', as: 'join_community'
  delete 'communities/:id', to: 'communities#leave_community', as: 'leave_community'

  resources :goals, except: %i[new] do
    resources :milestones, only: %i[index new create update destroy]
    resources :messages, only: %i[new create index]
    member do
      get 'buddy_assign'
      get 'confirm_buddy'
      get 'cancel_buddy'
    end
  end

  resources :milestones, only: %i[edit]

  resources :users, only: %i[show]

  # COMMUNITIES
  resources :communities, only: %i[index show] do
    resources :publications, only: :create
  end

  resources :publications, only: %i[create show destroy] do
    resources :claps, only: %i[new show create]
    resources :comments, only: %i[create]
  end
  resources :comments, only: %i[destroy]

  # USERS
  get "/dashboard/:id", to: "users#dashboard", as: 'dashboard'

  # USER_FEELINGS
  resources :user_feelings, only: %i[new create edit update show]


end
