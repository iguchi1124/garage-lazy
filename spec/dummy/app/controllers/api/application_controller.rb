class Api::ApplicationController < ActionController::API
  include Garage::ControllerHelper

  before_action :set_dataloaders

  private

  def set_dataloaders
    Current.article_loader =
      Dataloader.new do |*ids|
        Article.find(*ids)
      end

    Current.comments_by_article_id_loader =
      Dataloader.new do |article_ids|
        comments = Comment.where(article_id: article_ids)
        comments.group_by { |comment| comment.article_id }
      end

    Current.user_loader =
      Dataloader.new do |*ids|
        User.find(*ids)
      end
  end
end
