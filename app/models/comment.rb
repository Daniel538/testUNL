class Comment < ApplicationRecord
  validates :text, presence: true, length: {minimum: 3}
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
