class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    end
    @tweets = Tweet.all
    @user = current_user
    erb :'tweets/index'
  end

  post '/tweets' do
      user = current_user
    if !params[:content].empty?
      tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params['content'].empty?
      redirect '/tweets/#{params[:id]}/edit'
    end
    tweet.update(:content => params['content'])
    tweet.save
    redirect to '/tweets/#{tweet.id}'
  end

  post '/tweets/:id/delete' do
    if !logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
    end
    redirect to '/tweets'
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :'users/show'
  end


end
