Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#home"
  get :about, to: "pages#about"
  get '/profile', to: 'pages#profile'

  get ":scope",
    to: "commits#index",
    constraints: -> request { Commit::SCOPES.include?(request[:scope]) },
    as: :scopes

  resources :votes, only: :create
end
