class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :body, presence: true

  def to_resource
    CommentResource.new(self)
  end
end
