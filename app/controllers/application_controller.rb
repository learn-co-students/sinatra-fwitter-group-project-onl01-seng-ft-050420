require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  #homepage
  get '/' do
    erb :index
  end

 #homepage click signup view signup
  get '/signup' do
    if logged_in?(session)
      redirect to '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    if params.values.all? {|value| !value.empty?}
      @user = User.create(params)
      session[:user_id] = @user.id

      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  
  get '/login' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect to '/tweets'
    else
      redirect to '/failure'
    end
  end

  # get '/logout' do
  #   if logged_in?
  #     redirect 'users/logout'
  #   else
  #     redirect to '/login'
  #   end
  # end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect to '/login'
    else 
      redirect to '/'
    end
  end


  post '/logout' do
    if logged_in?(session)
      session.clear
      redirect to '/login'
    end
  end

  get '/failure' do

    erb :failure
  end
  helpers do
		def logged_in?(session)
			!!session[:user_id]
    end
    
		def current_user(session)
			User.find(session[:user_id])
    end
    
    def logout
      session.clear
    end

  end

end
