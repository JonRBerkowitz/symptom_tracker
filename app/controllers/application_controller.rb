require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "medical"
  end

  get '/' do
    redirect :'/signup'
  end

  get '/test' do
    current_user
    current_user
    current_user
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user = User.find(session[:user_id])
    end
  end

end
