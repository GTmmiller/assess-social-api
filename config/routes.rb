Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :comments
  post '/rating/:id', to: 'ratings#rate_user', as: 'rating'
  post '/post/', to: 'posts#create', as: 'post'

end
