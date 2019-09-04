Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :goals, only: %i[show] do
    resources :milestones, only: %i[index new create update]
    resources :messages, only: %i[new create index]
  end

  resources :milestones, only: %i[edit destroy]

  # routes to community
  resources :communities, only: :show

  # USERS
  get "dashboard", to: "users#dashboard"

  # USER_FEELINGS
  resources :user_feelings, only: %i[new create edit update show]
