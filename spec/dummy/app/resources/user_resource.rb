class UserResource
  include Garage::Representer
  include Garage::Authorizable

  property :id
  property :username
  property :image_url

  delegate :id, :username, :image_url, to: :@user

  def initialize(user)
    @user = user
  end
end
