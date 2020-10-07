class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
          :rememberable, :registerable,:validatable

  validates :first_name, presence: true, length: {minimum: 2}
  validates :last_name, presence: true, length: {minimum: 2}

  has_many :tasks

  def get_users
    User.select("id, first_name, last_name")
  end

  def get_full_name
    first_name + " " + last_name
  end
end
