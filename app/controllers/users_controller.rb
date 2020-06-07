class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
    else
      erb :'/users/create_user'
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

end
