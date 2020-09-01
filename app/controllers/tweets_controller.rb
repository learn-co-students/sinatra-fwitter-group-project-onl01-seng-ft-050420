require 'pry'

class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweets = Tweet.all 
            @users = User.all 
        else 
            redirect to '/login'
        end 
        erb :'tweets/index'
    end 

    get '/tweets/new' do 
        if Helpers.is_logged_in?(session)
            erb :'/tweets/new'
        else 
            redirect to '/login'
        end 
    end
    
    post '/tweets' do 
        @tweet = Tweet.new(params) 

        if @tweet.content == ""
            redirect to '/tweets/new'
        elsif @tweet.save 
            @user = Helpers.current_user(session)
            @user.tweets << @tweet 
            redirect to '/tweets'
        else 
            redirect to '/signup'
        end 
    end 

    get '/tweets/:id' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        else 
            @tweet = Tweet.find(params[:id])
            erb :"tweets/show"
        end 
    end 

    get 'tweets/:id/edit' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end 
        
        @tweet = Tweet.find(params[:id])
        
        if @tweet.user == Helpers.current_user(session)
            erb :'tweets/edit'
        else 
            redirect to '/login'
        end 
    end

    patch 'tweets/:id' do 
        @tweet = Tweet.find(params[:id])

        if params[:content].empty? 
            redirect to "/tweets/#{tweet.id}/edit"
        else 
            @tweet.update(content: params["content"])
            @tweet.save 
            redirect to "/tweets/#{tweet.id}"
        end 
    end 
end 

        


