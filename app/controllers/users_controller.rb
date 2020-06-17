class UsersController < ApplicationController


    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
    # get '/users/:id' do
    #     @user = User.find_by(username: params[:username])
    #     erb :"/users/show"
    # end

end
