Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # routes to community
  resources :communities, only: :show

  # USERS
  get "/dashboard/:id", to: "users#dashboard", as: 'dashboard'

  # USER_FEELINGS
  resources :user_feelings, only: %i[new create edit update]
end
