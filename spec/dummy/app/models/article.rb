class Article < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :slug, length: { minimum: 5, maximum: 30 }
  validates :title, length: { minimum: 5, maximum: 30 }
  validates :body, length: { minimum: 100 }

  def to_resource
    ArticleResource.new(self)
  end
end
