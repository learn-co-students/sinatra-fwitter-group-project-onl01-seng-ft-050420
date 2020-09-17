require './config/environment'
require 'pry'
require 'sinatra/flash'
require 'sinatra'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end
  get '/' do 
    "Welcome to Fwitter"
  end
  
  helpers do
    def is_logged_in?
      !!current_user
    end
    
    def current_user
      	@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  end

end

  

