class Task < ApplicationRecord

  validates :title, presence: true, length: {minimum: 6}
  validates :description, presence: true, length: {minimum: 6}
  validates :status, presence: true, inclusion: { in: ['new','in progress','done'],
                                                  message: "%{value} not status" }

  belongs_to :project
  belongs_to :user
end
