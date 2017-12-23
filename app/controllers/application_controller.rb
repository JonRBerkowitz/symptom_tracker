require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "medical"
  end

  get '/' do
    redirect :'/signup'
  end

  get '/posts' do
    if params[:type => "symptom"]
      @type = "symptom"
    elsif params[:type => "medication"]
      @type = "medication"
    end
    erb :'posts/new'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
