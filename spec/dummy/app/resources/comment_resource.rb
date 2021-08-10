class CommentResource
  include Garage::Representer
  include Garage::Authorizable
  include Garage::Lazy::Representer

  property :id
  property :body
  lazy_property :user, selectable: true

  delegate :id, :body, to: :@comment

  def initialize(comment)
    @comment = comment
  end

  def user
    @user ||= Current.user_loader.load(@comment.user_id).then { |user| user.to_resource }
  end
end
