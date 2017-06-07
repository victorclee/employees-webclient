Rails.application.routes.draw do
  get '/' => 'employees#index'
  get '/employees' => 'employees#index'
  get '/employees/new' => 'employees#new'
  post '/employees' => 'employees#create'
  get '/employees/:id' => 'employees#show'
end
