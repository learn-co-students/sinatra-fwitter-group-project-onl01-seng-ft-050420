class UsersController < ApplicationController
    
    get '/login' do #display the log in form 
        if session[:id] != nil 
            binding.pry 
            redirect to '/tweets'
        else
            erb :'/users/login'
        end 
    end 

    get '/signup' do #display signup form 
        if session[:id] != nil 
            redirect to '/tweets'
        else
            erb :'/users/create_user'
        end 
    end 

    get '/logout' do 
        if session[:id] == nil 
            redirect to '/login'
        else 
            erb :'/users/logout'
        end 
    end 

    get '/show' do 
        if session[:id] == nil 
            redirect to '/login'
        else 
            @user = User.find_by(id:session[:id])
            erb :'/users/show'
        end 
    end 

    post '/login' do #log the user in. Assign user_id to session[:hash]
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:id] = user.id 
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
            session[:id] = user.id
            redirect to "/tweets"
        end
    end 

    post '/logout' do 
        logout!
        redirect to '/login'
    end

end
