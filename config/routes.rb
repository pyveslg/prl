Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  resources :commits, only: [:index] do
    resources :votes, only: [:create]
    get '/delete_vote', to: 'votes#delete'
  end
end
