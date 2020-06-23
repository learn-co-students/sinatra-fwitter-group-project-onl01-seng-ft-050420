class TweetsController < ApplicationController

    get '/tweets' do #index page shows the users and every other tweet
        if session[:id] != nil#if user is not logged in, redirect to '/login'
            @user = User.find_by(id: session[:id])
            erb :'/tweets/tweets'
        else  
            redirect to '/login'
        end 
    end 

    get '/tweets/new' do #the form to create a new tweet 
        if session[:id] == nil
            redirect to '/login'
        else
            erb :'/tweets/new'
        end 
    end 

    get '/tweets/:id' do #show a single tweet
        if session[:id] == nil
            redirect to '/login'
        else
           @tweet = Tweet.find(params[:id])
           erb :'/tweets/show_tweet'
        end 
    end 

    get '/tweets/:id/edit' do #edit a single tweet 
        if session[:id] == nil
            redirect to '/login'
        else
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit_tweet'
        end
    end 

    post '/tweets' do #with get '/tweets/new' redirect to '/tweets'
        if params[:content] == "" 
            redirect to '/tweets/new'
        else
            user = User.find(session[:id])
            user.tweets.build(content: params[:content])
            user.save 
            redirect to '/tweets'
        end 
    end 

    patch '/tweets/:id' do #update the tweet a redirect to single tweet page '/tweets/:id'
      
        @tweet = Tweet.find(params[:id])
        @tweet.content = params[:content]
        @tweet.save 
        redirect to "/tweets/#{@tweet.id}"
    end 

    delete '/tweets/:id/delete' do #delete button should be found on show page
        if session[:id] == nil
            redirect to '/login'
        else
            @tweet = Tweet.find(params[:id])
            @tweet.destroy 
            redirect to '/tweets'
        end 
    end 

end
