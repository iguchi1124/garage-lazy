class ArticleResource
  include Garage::Representer
  include Garage::Authorizable
  include Garage::Lazy::Representer

  property :id
  property :title
  property :body
  lazy_property :user
  lazy_collection :comments

  delegate :id, :title, :body, to: :@article

  def initialize(article)
    @article = article
  end

  def user
    @user ||= Current.user_loader.load(@article.user_id).then { |user| user.to_resource }
  end

  def comments
    @comments ||= Current.comments_by_article_id_loader.load(@article.id).then { |comments| comments.map(&:to_resource) }
  end
end
