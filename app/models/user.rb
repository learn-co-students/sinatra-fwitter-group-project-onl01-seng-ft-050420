class User < ActiveRecord::Base
  extend Slug::ClassMethods
  include Slug::InstanceMethods

  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username, :email
end
