Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: %i[show]

  # COMMUNITIES
  resources :communities, only: %i[index show]

  resources :publications, only: %i[show] do
    resources :claps, only: %i[new show create]
  end

  # USERS
  get "dashboard", to: "users#dashboard"

  # USER_FEELINGS
  resources :user_feelings, only: %i[new create edit update show]
end
