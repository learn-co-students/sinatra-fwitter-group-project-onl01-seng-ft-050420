class TweetsController < ApplicationController
  
  get '/tweets' do
    @tweets = Tweet.all
    
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    content = params[:content]
    id = current_user.id
    
    if content != ""
      @tweet = Tweet.create(content: content, user_id: id)
    else
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:id' do
    id = params[:id]
    
    if logged_in?
      @tweet = Tweet.find_by_id(id)
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    id = params[:id]
    user = current_user
    
    if logged_in?
      @tweet = Tweet.find_by(id: id, user_id: current_user.id)
      if @tweet != nil
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    id = params[:id]
    content = params[:content]
    user = current_user
    
    if logged_in?
      @tweet = Tweet.find_by(id: id, user_id: current_user.id)
      if @tweet != nil && content != ""
        @tweet.content = content
        @tweet.save
      else
        redirect "/tweets/#{id}/edit"
      end
    else
      redirect '/login'
    end
  end
  
  delete '/tweets/:id' do
    id = params[:id]
    user = current_user
    
    if logged_in?
      @tweet = Tweet.find_by(id: id, user_id: current_user.id)
      if @tweet != nil
        @tweet.delete
      else
        redirect "/tweets/#{id}/edit"
      end
    else
      redirect '/login'
    end
  end
end
