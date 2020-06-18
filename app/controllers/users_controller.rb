class UsersController < ApplicationController
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
    
        erb :'users/show'
    end
    # #if logged in go here all users
    # get '/users' do
    #     @users = User.all

    #     erb :'users/index'
    # end

    # #the post request from SIGNUP
    # post '/users' do
       
    # # if logged_in? 
    #   redirect '/users'
    # # else
    # #   redirect '/login'
    # # end
    # end

    # get '/users/new' do

    #     erb :'users/new'
    # end

    # get '/users/:id' do

    # end

    # get '/users/:id/edit' do

    # end

    # patch '/users/:id' do

    # end

    # delete '/users/:id' do

    # end
end
