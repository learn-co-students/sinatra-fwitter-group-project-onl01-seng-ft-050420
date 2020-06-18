require_relative './concerns/slugifiable'

class Tweet < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  
  belongs_to :user
end
