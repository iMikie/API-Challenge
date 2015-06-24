class User < ActiveRecord::Base
  has_many :articles
  has_many :comments
  # has_many :comments, through: :articles
  has_many :article_comments,
    through: :articles,
    class_name: 'Comment',
    source: :comments
  has_many :keys
end
