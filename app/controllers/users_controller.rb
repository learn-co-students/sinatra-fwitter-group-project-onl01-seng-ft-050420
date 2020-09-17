require 'pry'

class UsersController < ApplicationController

  get '/signup' do 
      if !is_logged_in? 
        erb :'/users/signup'
      else
        redirect '/tweets'
      end
  end
  
  post '/signup' do 
   
      if params[:username]  != "" && params[:email] != "" && params[:password] != ""
        @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      end  
      if @user
            session[:user_id] = @user.id
            redirect '/tweets'
      else 
            redirect '/signup'
      end
  end
  
  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end
  post '/login' do 
    @user = User.find_by_username(params[:username])
   
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
          flash[:message] = "Welcome"
        redirect '/tweets'  
    else
 
        redirect '/login'
    end
        
  end
  
  get '/logout' do 

    if !!current_user
      redirect '/login'
    else 
      redirect '/logout'
    end
  end
  
  # post '/logout' do
  #     session.destroy
  #     redirect '/login'
      
  # end
  get '/users/:slug' do
    @tweets = current_user.tweets
    @user = User.find_by_slug(params[:slug]) #model slug
    erb :'/users/show'
  end
  
  post '/users' do  #creating a new user
  
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])

    redirect '/users/show'
  end
  
    
  
end

