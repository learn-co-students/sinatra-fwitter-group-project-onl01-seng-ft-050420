class UsersController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "secret"
      end

    get '/signup' do #display signup form
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end 
    end 

    get '/login' do #display the log in form 
        if logged_in? 
            redirect to '/tweets'
        else
            erb :'/users/login'
        end 
    end 

    get "/users/:slug" do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :'/users/show'
        else 
            redirect to '/login'
        end 
    end

    get '/logout' do 
        if logged_in?
            session.clear
            redirect to '/login'
            # erb :'/users/logout'
        else 
            redirect to '/'
        end 
    end 

    post '/signup' do #Create a user and log them in 
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
            redirect '/signup'
        else
            user = User.create(params)
            session[:user_id] = user.id
            redirect to "/tweets"
        end
    end 



    post '/login' do #log the user in. Assign user_id to session[:hash]
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 

            redirect to '/tweets'
        else  

            redirect to '/login'
        end 
    end







    # post '/logout' do 
    #     logout!
    #     redirect to '/login'
    # end




    get '/show' do 
        if session[:user_id] == nil 
            redirect to '/login'
        else 
            @user = User.find_by(id:session[:user_id])
            erb :'/users/show'
        end 
    end 






end
