class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
end
# user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
