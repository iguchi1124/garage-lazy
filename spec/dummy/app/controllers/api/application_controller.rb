class Api::ApplicationController < ActionController::API
  include Garage::ControllerHelper

  before_action :set_dataloaders

  private

  def set_dataloaders
    Current.article_loader =
      Dataloader.new do |*ids|
        Article.find(*ids)
      end

    Current.comment_loader =
      Dataloader.new do |*ids|
        Comment.find(*ids)
      end

    Current.user_loader =
      Dataloader.new do |*ids|
        User.find(*ids)
      end
  end
end
