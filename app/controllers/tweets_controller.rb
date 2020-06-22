class TweetsController < ApplicationController

    get '/tweets' do #index page shows the users and every other tweet
        if session[:user_id] != nil#if user is not logged in, redirect to '/login'
            @user = User.find_by(id: session[:user_id])
            erb :'/tweets/tweets'
        else  
            redirect to '/login'
        end 
    end 

    get '/tweets/new' do #the form to create a new tweet 
        erb :'/tweets/new'
    end 

    get '/tweets/:id' do #show a single tweet
        erb :'/tweets/show'
    end 

    get '/tweet/:id/edit' do #edit a single tweet 
        erb :'/tweets/edit_tweet'
    end 

    post '/tweets' do #with get '/tweets/new' redirect to '/tweets'
        #redirect to '/tweets'
    end 

    patch '/tweets/:id' do #update the tweet a redirect to single tweet page '/tweets/:id'
        #redirect to '/tweets/:id'
    end 

    delete '/tweets/:id/delete' do #delete button should be found on show page
        #redirect to '/tweets'
    end 

end
