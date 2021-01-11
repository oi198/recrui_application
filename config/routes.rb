Rails.application.routes.draw do
  
  get '/' => 'posts#index'
  get '/posts/:post_id/edit' => 'posts#edit'
  post '/posts/create' => 'posts#create'
  post '/posts/search' => 'posts#search'
  post '/posts/:post_id' => 'posts#change_current_post'
  post '/posts/:post_id/update' => 'posts#update'
  post '/posts/:post_id/destroy' => 'posts#destroy'


  get '/companies' => 'companies#index'
  get '/companies/:company_id' => 'companies#show'
  get '/companies/:company_id/edit' => 'companies#edit'
  post '/companies/create' => 'companies#create'
  post '/companies/:company_id/destroy' => 'companies#destroy'
  post '/companies/:company_id/update' => 'companies#update'


  post 'chats/:post_id/create' => 'chats#create'
  post 'chats/:chat_id/destroy' => 'chats#destroy'


  get '/users/:user_id' => 'users#index'
  get '/users/:user_id/edit' => 'users#edit'
  get '/signup' => 'users#signup'
  get '/login' => 'users#login_form'
  get '/users/:user_id/posts' => 'users#posts'
  get '/users/:user_id/chats' => 'users#chats'
  get '/users/:user_id/companies' => 'users#companies'
  post '/login' => 'users#login'
  post '/logout' => 'users#logout'
  post '/users/create' => 'users#create'
  post '/users/:user_id/destroy' => 'users#destroy'
  post '/users/:user_id/name_update' => 'users#name_update'
  post '/users/:user_id/img_update' => 'users#img_update'


  get '/events' => 'events#index'
  get '/events/:year/:month/:day' => 'events#show'
  get '/events/new/:year/:month/:day' => 'events#new'
  post '/events/create/:year/:month/:day' => 'events#create'
  post '/events/:event_id/:year/:month/:day/destroy' => 'events#destroy'


  get 'ess/:company_id/:es_id/edit' => 'ess#edit'
  post 'ess/:company_id/create' => 'ess#create'
  post 'ess/:company_id/:es_id/update' => 'ess#update'
  post 'ess/:company_id/:es_id/destroy' => 'ess#destroy'


  get '/users/:user_id/name_update' => 'errors#index'
  get '/companies/:compay_id/update' => 'errors#index'
  get '/posts/:post_id/update' => 'errors#index'
  post '/events/create' => 'errors#index'


  resources :posts
  root 'posts#index'
end
