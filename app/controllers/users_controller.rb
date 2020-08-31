class UsersController < ApplicationController
  get '/' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'users/homepage'
    end
  end

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  post '/signup' do
    user = User.new(params)
    if user.save # Leverages validators in `User`
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
