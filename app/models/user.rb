class User < ApplicationRecord
  devise :database_authenticatable,
    :rememberable, :registerable,:validatable

  validates :first_name, presence: true, length: {minimum: 2}
  validates :last_name, presence: true, length: {minimum: 2}

  has_many :comments, dependent: :destroy
  has_many :created_by, class_name: "Task", foreign_key: "created_by_id", dependent: :destroy

  def get_users
    User.select("id, first_name, last_name")
  end

  def get_full_name
    first_name + " " + last_name
  end
end
