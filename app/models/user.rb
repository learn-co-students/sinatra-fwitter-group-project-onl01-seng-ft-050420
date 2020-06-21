require_relative './concerns/slugifiable'

class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_secure_password
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_many :tweets
end
