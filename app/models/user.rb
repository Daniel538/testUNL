class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
          :rememberable, :registerable,:validatable

  validates :first_name, presence: true, length: {minimum: 6}
  validates :last_name, presence: true, length: {minimum: 6}
end
