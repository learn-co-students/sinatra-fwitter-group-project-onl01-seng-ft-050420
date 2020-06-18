class TweetsController < ApplicationController
    
    #if logged in go here all tweets
    get '/tweets' do
        if logged_in?(session)
            @user = current_user(session)
            @tweets = Tweet.all
            erb :'tweets/index'
        else
            redirect to '/login'
        end
    end

    #the post request from SIGNUP
    post '/tweets' do
        if logged_in?(session)
            if params[:content] == ""
                redirect to '/tweets/new'
            else
                tweet = Tweet.new(content: params[:content])
                tweet.user = current_user(session)
                if tweet.save
                    redirect to "tweets/#{tweet.id}"
                else
                    redirect to 'tweets/new'
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?(session) 
            
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            @user = current_user(session)

            erb :'tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
       
        if logged_in?(session) 
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user(session)

                erb :'tweets/edit'
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        if logged_in?(session)
            if params[:content] == ""
                redirect to "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find_by_id(params[:id])
                if @tweet && @tweet.user == current_user(session)
                    @tweet.content = params[:content]
                    if @tweet.save      
                        redirect "/tweets/#{@tweet.id}"
                    else
                        redirect to "/tweets/#{tweet.id}/edit"
                    end
                else
                    redirect to '/tweets'
                end
            end
        else
            redirect to '/login'
        end
    end

    delete '/tweets/:id' do 
        if logged_in?(session)
            tweet = Tweet.find_by_id(params[:id])
            if tweet && tweet.user == current_user(session)
                tweet.destroy
            end
            redirect to "/tweets"
        else
            redirect to '/login'
        end
    end


end
