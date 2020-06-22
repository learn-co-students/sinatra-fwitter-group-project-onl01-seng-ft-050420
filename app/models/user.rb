class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def slug
    username.downcase.tr(" ", "-")
  end

  def self.find_by_slug(slug)
      
      self.find_by(username: slug.tr("-"," "))
  end 
   
end
