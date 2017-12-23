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

end
