Rails.application.routes.draw do
  # devise_for :users
  # resources :blogs
  root 'posts#index'
  resources :posts
  devise_for :users, controllers:{
    sessions: 'users/sessions'
    }

  get '/users/index' => 'users#index'
  #rake route???
  # resourece :posts #아래 주석하고 하면 내가 가진 경로들 다 볼 수 있음
  # # index
  # get '/posts' => 'posts#index'
  #
  # #Create
  # get '/posts/new' => 'posts#new'
  # post '/posts' => 'posts#create'
  #
  # #Read
  # get '/posts/:id' =>'posts#show'
  #
  # #Update
  # get '/posts/:id/edit' =>'posts#edit'
  # put '/posts/:id' =>'posts#update'
  #
  # #Delete
  # delete '/posts/:id' => 'posts#destroy'
end
