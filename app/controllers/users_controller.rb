class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end
  
  post '/signup' do
    username = params[:username]
    email = params[:email]
    password = params[:password]
     
    if username == "" || email == "" || password == ""
      redirect '/signup'
    else
      @user = User.create(username: username, email: email, password: password)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end
  
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
    username = params[:username]
    user = User.find_by(username: username)
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
