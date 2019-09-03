Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # USERS
  get "dashboard", to: "users#dashboard"

  # USER_FEELINGS
  resources :user_feelings, only: %i[new create edit update show]
end
