class TweetsController < ApplicationController
  get '/tweets' do
    if !session[:user_id]
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end

  post '/tweets' do 
    if !params[:content].empty?
      current_user.tweets.create(content: params[:content])
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/new' do 
    if is_logged_in?
      # binding.pry
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end
end
