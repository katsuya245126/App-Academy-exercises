class Comment < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :user_id
  belongs_to :artwork
  has_many :likes, as: :likeable
end
