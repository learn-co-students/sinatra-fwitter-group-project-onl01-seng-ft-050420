require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "MySecret" 
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect to "/tweets"
    else 
      erb :signup
    end 
  end

  post '/signup' do 
    if params.values.all? { |value| value != ""}
      @user = User.create(params)
      session[:user_id] = @user.id

      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect to "/tweets"
    else 
      erb :login
    end 
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])      
      session[:user_id] = user.id

      redirect to "/tweets"
    else 
      redirect to "/failure"
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      redirect to '/login'
    else 
      redirect to '/'
    end
  end

  get '/failure' do
    erb :failure
  end

end
