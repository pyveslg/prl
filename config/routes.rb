Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  Commit::SCOPES.values.uniq.each do |scope|
    get "/#{scope}", to: 'commits#index'
  end

  resources :commits, only: :index
  resources :votes, only: :create
end
