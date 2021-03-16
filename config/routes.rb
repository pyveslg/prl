Rails.application.routes.draw do
  root to: "pages#home"
  get :about, to: "pages#about"

  get ":scope",
    to: "commits#index",
    constraints: lambda {|request| Commit::SCOPES.keys.include?(request[:scope])},
    as: :scopes

  resources :votes, only: :create
end
