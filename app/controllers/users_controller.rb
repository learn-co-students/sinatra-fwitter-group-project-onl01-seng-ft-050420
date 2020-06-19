class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by(username: slug_convert(params[:slug]))
    erb :'/users/show'
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      redirect to '/tweets'
    end
  end
  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if !session[:user_id]
      redirect '/login'
    else
      session.clear
      redirect to '/login'
    end

  end

  post '/logout' do
    session.clear
    redirect to '/login'
  end


end
