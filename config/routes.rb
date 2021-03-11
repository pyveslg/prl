Rails.application.routes.draw do
  root to: "pages#home"
  get :about, to: "pages#about"

  get ":scope",
    to: "commits#index",
    constraints: { scope: Commit::SCOPES.keys }

  resources :votes, only: :create
  resources :commits, only: :index

end
