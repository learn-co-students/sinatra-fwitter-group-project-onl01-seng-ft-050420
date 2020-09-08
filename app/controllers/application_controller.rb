require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do 
    "Welcome to Fwitter"
  end
  
  get 'signup' do 
    erb :'/signup'
  end
  post 'signup' do 
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    redirect '/signup'
  end
end
