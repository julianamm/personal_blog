Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # /admin/...
  namespace :admin do
    # GET /admin/dashboard
      resources :dashboard, only: [:index]
    end
    
    # GET /session/new
    resource :session, only: [:new, :create, :destroy]
    # GET /users/new
    get "/users/:id/edit_password", to: "users#edit_password", as: :edit_password
    patch "/users/:id/update_password", to: "users#update_password", as: :update_password
    resources :users, only: [:new, :create, :edit, :update, :show]
    # RESTful routes
    # /posts/:post_id/comments
    resources :posts do
      # get :my_route
      resources :comments, only: [:create, :destroy]
    end
  
    # Routes for PostsController
    #  get "/posts/new", to: "posts#new", as: :new_post
    #  post "/posts", to: "posts#create", as: :posts
    #  get "/posts/:id", to: "posts#show", as: :post
    #  get "/posts/:id/edit", to: "posts#edit", as: :edit_post
    #  patch "/posts/:id", to: "posts#update"
    #  delete "/posts/:id", to: "posts#destroy"
    get "/", to: "posts#index", as: :home
end