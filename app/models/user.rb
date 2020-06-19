class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true
  validates :username, uniqueness: true
  has_many :tweets
  def slug
    slug = self.username.split(" ")
    slug.join("-")
  end

  def self.find_by_slug(slug)
    unslug = slug.gsub("-", " ")
    User.find_by(username: unslug)
  end
end
