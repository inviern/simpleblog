class Post < ActiveRecord::Base

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :title,   presence: true,
                      length: { maximum: 255 }

  validates :text,    length: { maximum: 10000 }

  validates :author,  presence: true
end
