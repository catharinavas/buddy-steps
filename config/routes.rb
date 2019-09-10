Rails.application.routes.draw do

  devise_for :users
  root to: 'communities#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # action cabel (chat)
  mount ActionCable.server => "/cable"

  post 'communities/:id', to: 'communities#join_community', as: 'join_community'
  delete 'communities/:id', to: 'communities#leave_community', as: 'leave_community'

  resources :goals, except: %i[new] do
    resources :milestones, only: %i[new create update destroy]
    resources :messages, only: %i[create]
    member do
      get 'completed'
      get 'buddy_assign'
      get 'confirm_buddy'
      get 'cancel_buddy'
    end
  end

  resources :milestones, only: %i[edit]
  get 'milestones/:id', to: 'milestones#toggle_complete', as: 'milestones_complete'

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
  get "/dashboard", to: "users#dashboard", as: 'dashboard'

  # USER_FEELINGS
  resources :user_feelings, only: %i[new create edit update show]

  # ROOM CHAT

  resources :rooms, only: %i[create show] do
    resources :room_messages, only: :create
  end
end
