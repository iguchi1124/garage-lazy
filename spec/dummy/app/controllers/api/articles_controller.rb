class Api::ArticlesController < Api::ApplicationController
  include Garage::RestfulActions
  include Garage::Lazy::RestfulActions

  def require_promises
    article_ids = Article.page(page).per(per_page).pluck(:id)
    Current.article_loader.load_many(article_ids).then { |articles| articles.map(&:to_resource) }
  end

  private

  def per_page
    params[:per_page] || 20
  end

  def page
    params[:page] || 1
  end
end
