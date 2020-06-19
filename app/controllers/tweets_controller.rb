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
  get '/tweets/:id' do
    if !is_logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    end
  end
  get '/tweets/:id/edit' do
    if !is_logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    end
  end
  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if !params[:content].blank?
      tweet.update(content: params[:content])
      redirect '/tweets/' + tweet.id.to_s
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.user == current_user
      tweet.destroy
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end
end
