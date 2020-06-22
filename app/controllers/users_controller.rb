class UsersController < ApplicationController
    
    get '/login' do #display the log in form 
        if session[:user_id] != nil 
            redirect to '/tweets'
        else
            erb :'/users/login'
        end 
    end 

    get '/signup' do #display signup form 
        if session[:user_id] != nil 
            redirect to '/tweets'
        else
            erb :'/users/create_user'
        end 
    end 

    get '/logout' do 
        if session[:user_id] == nil 
            redirect to '/'
        else 
            erb :'/users/logout'
        end 
    end 

    # get '/show' do 
    #     erb :'/users/show'
    # end 

    post '/login' do #log the user in. Assign user_id to session[:hash]
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else  
            redirect to '/login'
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

    post '/logout' do 
        logout!
        redirect to '/login'
    end

end
