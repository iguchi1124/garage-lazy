class User < ApplicationRecord
  has_many :articles
  has_many :comments

  has_secure_password

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  def image_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.strip.downcase)}"
  end

  def to_resource
    UserResource.new(self)
  end
end
