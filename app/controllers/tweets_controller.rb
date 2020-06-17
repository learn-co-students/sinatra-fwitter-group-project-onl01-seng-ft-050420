class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.logged_in?(session)
          @user = Helpers.current_user(session)
          @tweets = Tweet.all
          erb :"/tweets/index"
        else 
          redirect to "/login"
        end 
      end
    
      get '/tweets/new' do
        if Helpers.logged_in?(session)
          erb :"/tweets/new"
        else 
          redirect to "/login"
        end 
      end

      post '/tweets' do
        if params[:content].empty?
          redirect to "/tweets/new"
        else
          user = Helpers.current_user(session)
          user.tweets.create(content: params[:content])
        end 
      end

      get '/tweets/:id' do
        if Helpers.logged_in?(session)
          @tweet = Tweet.find_by(id: params[:id])
          erb :"/tweets/show"
        else 
          redirect to "/login"
        end 
      end
    
      get '/tweets/:id/edit' do
        if Helpers.logged_in?(session) && @tweet = Helpers.current_user(session).tweets.find_by(id: params[:id])
          erb :"/tweets/edit"
        else 
          redirect to "/login"
        end
      end

      patch '/tweets/:id' do
        tweet = Tweet.find_by(id: params[:id])
        if params[:content].empty?
          redirect to "/tweets/#{tweet.id}/edit"
        else 
          tweet.update(content: params[:content])
          tweet.save
        end 
      end
    
      delete '/tweets/:id' do
        tweet = Tweet.find_by(id: params[:id])
        tweet.delete if tweet.user == Helpers.current_user(session)
        redirect to "/tweets"
      end 

end
