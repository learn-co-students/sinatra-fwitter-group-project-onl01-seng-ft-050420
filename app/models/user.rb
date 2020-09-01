class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_digest, presence: true 
  has_secure_password
  has_many :tweets
end
