class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      redirect "/users/#{@user.id}"
    else
    erb :'users/signup'
    end
  end

  post '/signup' do
    if User.find_by(:username => params[:username])
      redirect '/signup'
    elsif
      User.find_by(:email => params[:email])
      redirect '/signup'
    else
      if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
      else
        redirect '/signup'
      end
    end
  end

  get '/login' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      redirect "/users/#{@user.id}"
    else
    erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/signup'
    end
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    if @user == current_user
    erb :'users/show'
    else
      redirect '/'
    end
  end

end
