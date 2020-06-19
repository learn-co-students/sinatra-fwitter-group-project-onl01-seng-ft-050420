class TweetsController < ApplicationController
  get '/tweets' do
    if !session[:user_id]
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    end
  end
end
