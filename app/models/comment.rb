class Comment < ApplicationRecord
  validates :text, presence: true, length: {minimum: 3}
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
end
