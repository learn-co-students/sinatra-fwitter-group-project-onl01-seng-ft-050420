class TweetsController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "secret"
      end

    get '/tweets' do #index page shows the users and every other tweet
         
        if logged_in? #if user is not logged in, redirect to '/login'
            @user = current_user 
            @tweets = Tweet.all 
             
            erb :'/tweets/tweets'
        else  
            redirect to '/login'
        end 
    end 

    get '/tweets/new' do #the form to create a new tweet 
         
        if logged_in? 
            erb :'/tweets/new'
        else 
            redirect to '/login'
        end 
    end 

    get '/tweets/:id' do #show a single tweet
         
        if logged_in? 
            @user = current_user
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end 
    end 

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id]) # slug helps to find by name instaed of ID
            erb :'tweets/edit_tweet'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do #with get '/tweets/new' redirect to '/tweets'
    
        if params[:content] == "" 
            redirect to '/tweets/new'
        else
            @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
            # user = User.find(session[:id])
            # user.tweets.build(content: params[:content])
            # user.save 
           
            redirect to '/tweets'
        end 
    end 

    patch '/tweets/:id' do #update the tweet a redirect to single tweet page '/tweets/:id'
        @tweet = Tweet.find(params[:id])
        if params[:content] == "" 
            redirect to "/tweets/#{@tweet.id}/edit"
        else 
            @tweet.content = params[:content]
            @tweet.save 
            redirect to "/tweets/#{@tweet.id}"
        end 
    end 

    delete '/tweets/:id/delete' do #delete button should be found on show page
        @tweet = Tweet.find(params[:id])
        if current_user == @tweet.user
            @tweet.destroy
            redirect to '/tweets'
        else
            redirect to '/tweets'
        end
    end 

end
