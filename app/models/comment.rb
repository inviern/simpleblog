class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :text, presence: true, length: { maximum: 10_000 }
  validates :post, presence: true
  validates :author, presence: true
end
