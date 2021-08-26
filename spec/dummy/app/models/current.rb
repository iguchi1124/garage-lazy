class Current < ActiveSupport::CurrentAttributes
  attribute :user_loader
  attribute :article_loader
  attribute :comments_by_article_id_loader
end
