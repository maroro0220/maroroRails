Rails.application.routes.draw do
  resources :blogs
  root 'posts#index'

  #rake route???
  # resourece :posts #아래 주석하고 하면 내가 가진 경로들 다 볼 수 있음
  # index
  get '/posts' => 'posts#index'

  #Create
  get '/posts/new' => 'posts#new'
  post '/posts' => 'posts#create'

  #Read
  get '/posts/:id' =>'posts#read'

  #Update
  get '/posts/:id/edit' =>'posts#edit'
  put '/posts/:id' =>'posts#update'

  #Delete
  delete '/posts/:id' => 'posts#destroy'
end
