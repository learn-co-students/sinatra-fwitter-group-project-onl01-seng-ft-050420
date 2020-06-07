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
end
