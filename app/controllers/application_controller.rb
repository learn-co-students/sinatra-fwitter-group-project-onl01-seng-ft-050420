require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "password_security"
  end

  get '/' do 
    erb :index 
  end 

  helpers do 
    def is_logged_in?(session) 
      !!session[:user_id]
    end

  #   def login(email, password)
  #     user = User.find_by(email: email) 
  #     if user && user.authenticate(password)
  #     session[:email] = user.email 
  #    else 
  #     redirect '/'
  #    end 
  #   end 

    def logout! 
      session.clear 
    end
  end 

end
