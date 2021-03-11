Rails.application.routes.draw do
  root to: "pages#home"
  get :about, to: "pages#about"

  resources :votes, only: :create
  resources :commits, only: :index

  Commit::SCOPES.values.uniq.each do |scope|
    get "/#{scope}", to: 'commits#index'
  end
end
