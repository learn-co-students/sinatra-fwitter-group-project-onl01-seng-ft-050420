class TweetsController < ApplicationController

   get  '/tweets' do
        if !logged_in?
            redirect "/login"
        end 
        
        @tweets = Tweet.all
        erb :"tweets/tweets"     
   end

   get '/tweets/new' do
        if !logged_in?
            redirect "/login"
        else 
            erb :'tweets/new'
        end
    end 

   post '/tweets' do
        tweet = Tweet.new(content: params[:content], user_id: session[:user_id])

        if tweet.save 
            redirect :"/tweets"
        else
            redirect :'/tweets/new'
        end     
   end 

   get '/tweets/:id' do
        if !logged_in?
            redirect "/login"
        else 
            @tweet = Tweet.find(params[:id]) 
            erb :'/tweets/show'
        end
    end
    
    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == session[:user_id]  
            erb :'/tweets/edit'
            else 
                redirect :'/tweets'
            end
        else
            redirect :'/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == session[:user_id] && @tweet.update(content: params["content"])
            redirect to "tweets/#{@tweet.id}"
        else
            redirect to "tweets/#{@tweet.id}/edit"
        end  
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == session[:user_id]  
            @tweet.destroy
        end
        redirect to '/tweets'
    end 
end

