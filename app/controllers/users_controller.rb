require 'pry'

class UsersController < ApplicationController

    get '/' do
        erb :index
    end
    
    get '/signup' do
        if Helpers.is_logged_in?(session)
            erb :"/tweets/index"
        else
            erb :'users/new'
        end
    end 

    post '/signup' do
        @user = User.new(params)

        if @user.username == "" || @user.email == "" || @user.password == ""
            redirect to "/new"
        elsif @user.save
            session[:id] = @user.id
            redirect to "/tweets"
        else
            redirect to "/new"
        end
    end 

    get '/login' do
        if Helpers.is_logged_in?(session)
            Helpers.current_user(session)
            redirect to "/tweets"
        else
            erb :'users/login'
        end
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])

        if @user && @user.authenticate(params[:password])
            session[:id] = @user.id
            redirect to "/tweets"
        else
            binding.pry
            redirect to "/login"
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
        end
        redirect to "/login"
    end


end
