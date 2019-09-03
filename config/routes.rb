Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

<<<<<<< HEAD
  resources :communities, only: %i[index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
=======
  # USERS
  get "dashboard", to: "users#dashboard"

  # USER_FEELINGS
  resources :user_feelings, only: %i[new create edit update show]
>>>>>>> master
end
