Rails.application.routes.draw do

  devise_for :users

  root "posts#index"

  get "posts/search" , to: "posts#search"

  resources :posts do
		resources :comments
  end

  resources :users

end
