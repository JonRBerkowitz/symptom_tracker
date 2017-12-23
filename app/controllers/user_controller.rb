class UserController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/users' do
    @user = User.create(params)
    redirect "/users/{#@user.id}"
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'users/show'
  end

end
