Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  resources :users, only: [:index, :show]
  get '/users/:id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:id/posts/:id', to: 'posts#show', as: 'user_post'
end
