Rails.application.routes.draw do
  root to: "pages#home"
  get :about, to: "pages#about"
  resources :commits, only: :index
  resources :votes, only: :create
end
